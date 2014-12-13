var activeFilters = [];
var activeCategories = [];
var activeLocations = [];

$(document).ready(function() {
    hideEventDetails();
    activateFrontPageListeners();
});

function activateFrontPageListeners() {
    $('span.event-topbar_js').click(toggleContent);
    $('a[data-role="filter-link"]').click(filterCategory);
    $('.show-long-description_js').click(toggleLongDescription);
}

/**
 *  Because of a jQuery bug, we need to inform
 *  jQuery of the event-detail's height so that
 *  the slideToggle doesn't "jump".
 *  See https://coderwall.com/p/r855xw for details.
 */
function hideEventDetails() {
    $('.event-details').each(function(){
        $height = $(this).height();
        $(this).css('height', $height);
        $(this).hide();
    })
}

/**
 *   If this container's details div is exposed, hide it
 *   otherwise, hide any exposed details div and show the
 *   current container's details div.
 */
function toggleContent() {
    if  ($(this).siblings('.event-details').hasClass('revealed')) {
        $(this).siblings('.event-details').removeClass('revealed').slideToggle('fast');
    } else {
        $('.revealed').removeClass('revealed').slideToggle();
        $(this).siblings('.event-details').addClass('revealed').slideToggle('fast');
    }
}

/**
 * Given a change in filter state
 * add or remove active class from filters
 * to change display of active filters in the view.
 */
function refreshFilterView(){
    $('a.filter-link').each(function(){
        var filter = $(this).attr('data-toggle');
        if (activeFilters.indexOf(filter) >= 0) {
            $(this).addClass('active');
        } else if ($(this).hasClass('active')) {
            $(this).removeClass('active')
        }
    })
}

/**
 * When a user clicks on a filter-link
 * hide all events that do not have that category
 * and show filter as active in DOM
 * @returns {boolean}
 */
function filterCategory(){
    var $this = $(this);
    var filter = $this.attr('data-toggle');
    var $allMatching = $('[data-toggle="' + filter + '"]');
    var type = $this.attr('data-filter-type');
    var filterArray;
    if (type == 'category') {
        filterArray = activeCategories;
    } else if (type == 'location') {
        filterArray = activeLocations;
    }
    if (activeFilters.indexOf(filter) == -1) {
        $this.addClass('active tag label label-primary');
        activeFilters.push(filter);
        filterArray.push(filter);
    } else if ($this.hasClass('active')){
        $allMatching.removeClass('active tag label label-primary');
        activeFilters.remove(filter);
        filterArray.remove(filter);
    }
    refreshFilterView();
    evaluateShown();
    return false;
}

/**
 * Decide what events and dates to show,
 * and how to display the filter text.
 */
function evaluateShown(){
    /**
     * if there is at least one active filter
     * hide all events that do not have a category matching our filters
     * else show all events
     */
    function evaluateEventVisibility() {
        var events = $('[data-role="event"]');

        if (activeFilters.length == 0) {
            events.show();
            $('[data-role="day"]').show();
        } else {
            events.each(function (i) {
                var $this = $(this);
                var categories = $this.attr('data-categories').split(' ');
                var location = $this.attr('data-location');
                var parentId = '#' + $this.attr('data-parent');
                if ($this.is(':hidden')) {
                    if (attributesMatchFilters(categories, location)) {
                        $this.show();
                        $(parentId).show();
                    }
                } else if ($this.is(':visible')) {
                    if (!attributesMatchFilters(categories, location)) {
                        $this.hide();
                    }
                }
            });
        }
    }

    /**
     * If a date has no visible child events, hide it
     * Otherwise, show it.
     */
    function evaluateDateVisibility() {
        $('[data-role="day"]').each(function (i) {
            var childEvents = $(this).find('[data-role="event"]');
            var numVisible = numVisibleChildEvents(childEvents);
            if (numVisible > 0) {
                $(this).show();
                // update the number contained within the header
                $(this).find('[data-role="day-event-count"]').text('(' + numVisible + ')');
            } else {
                $(this).hide();
            }
        });
    }

    /**
     * Create a description of the currently active filters based on
     * the filter lists. This description includes text and a set of tags
     * which are rendered with links and listeners allowing them to be
     * removed again.
     */
    function evaluateFilterDescription(){
        //Create a nice html tag for a given filter type
        // including the correct data-attributes to enable
        // it to function to remove things
        function createTagLink(name, type){
            var label_type;
            if (type == 'category'){
                label_type = 'label-primary';
            } else if (type == 'location') {
                label_type = 'label-success';
            }
            tag = "<span class='tag label " + label_type + "'>";
            tag += name;
            tag += "<a class='active' data-role='filter-link' data-filter-type='" + type + "' data-toggle='" + name + "'>";
            tag += "<span class=\"remove glyphicon glyphicon-remove glyphicon-white\"></span></a></span>";
            return tag;
        }

        var text = i18n.calendar.index.describe_filters.base;
        if (activeCategories.length > 0 ){
            text += i18n.calendar.index.describe_filters.categories;
            var categories = $.map(activeCategories, function(name, i){
                return createTagLink(name, 'category');
            });
            text += categories.join(' ');
        }
        if (activeLocations.length > 0 ){
            text += i18n.calendar.index.describe_filters.locations;
            var locations = $.map(activeLocations, function(name, i){
                return createTagLink(name, 'location');
            });
            text += locations.join(' ');
        }

        var $description = $('[data-role="filter-description"]');
        $description.html(text);
        if (activeCategories.length > 0 || activeLocations.length > 0) {
            $description.removeClass('hidden');
        } else {
            $description.addClass('hidden');
        }
        $('a[data-role="filter-link"]').unbind().click(filterCategory);
    }

    evaluateEventVisibility();
    evaluateDateVisibility();
    evaluateFilterDescription();
}

/**
 * Search all given events and returns
 * the number that are visible.
 * @param childEvents
 * @returns {Integer}
 */
function numVisibleChildEvents(childEvents) {
    var visible = 0;
    $(childEvents).each(function(i) {
        if ($(this).is(':visible')) {
            visible += 1;
            //return false; //return false to break out of the each loop
        }
    });
    return visible;
}

/**
 * This function checks if an event
 * has any of the requested categories
 * or takes place in any of the requested locations.
 *
 * @param eventCategories
 * @returns {boolean}
 */
function attributesMatchFilters(eventCategories, eventLocation) {
    function matchingLocation(location){
        if (activeLocations.length == 0) return true;
        return (activeLocations.indexOf(location) >= 0);
    }

    function matchingCategories(categories) {
        if (activeCategories.length == 0) return true;
        for (var i = 0; i < activeCategories.length; i++) {
            if (eventCategories.indexOf(activeCategories[i]) >= 0) {
                return true;
            }
        }
        return false;
    }
    return (matchingCategories(eventCategories) && matchingLocation(eventLocation));
}

/**
 * Given a change in filter state
 * Run through the list of active filters
 * and insert html elements to represent them.
 */
function updateActiveFilters(){
    refreshFilterView();
    var filterHTML = '';
    for (var i = 0; i < activeFilters.length; i++) {
        var filterName = activeFilters[i];
        var removeLink = ' <a href="" class="remove-filter" data-toggle="' + filterName + '"> [X] </a>';
        filterHTML += '<li>' + filterName.titleize() + removeLink + '</li>';
    }
    $('ul.active-filters_js').html(filterHTML);
}


function toggleLongDescription() {
    $(this).hide();
    $(this).siblings('.long-description').slideToggle();
    return false;
}