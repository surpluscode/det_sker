var activeFilters = [];
var activeCategories = [];
var activeLocations = [];

$(document).ready(function() {
    activateFrontPageListeners();
});

function activateFrontPageListeners() {
    $('a[data-role="filter-link"]').click(filterCategory);
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
    });
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
        function showEventAndParent(event){
          $event = $(event);
          $event.show();
          var parentId = '#' + $event.attr('data-parent');
          $(parentId).show();
        }
        function noFilters(){
            return (activeCategories.length == 0 && activeLocations.length == 0)
        }

        function findMatchingEvents(){
            var eventsWithValidCategory = [];
            var eventsWithValidLocation = [];
            activeCategories.forEach(function(cat) {
                Array.prototype.push.apply(eventsWithValidCategory, $('[data-categories~='+ cat +']').toArray());
            });
            activeLocations.forEach(function(loc) {
                Array.prototype.push.apply(eventsWithValidLocation, $('[data-location='+ loc +']').toArray());
            });
            // 1. identify all the matching objects (i.e. intersection of A & B)
            // 2. hide all other objects (i.e. E - (A intersection B))
            var matchingEvents = [];
            if (activeCategories.length > 0 && activeLocations.length > 0) {
                matchingEvents = Util.intersection(eventsWithValidCategory, eventsWithValidLocation);
            } else if (activeCategories.length > 0) {
                matchingEvents = eventsWithValidCategory;
            } else if (activeLocations.length > 0) {
                matchingEvents = eventsWithValidLocation;
            }
            return matchingEvents;
        }

        var events = $('[data-role="event"]').toArray();
        if (noFilters()) {
            events.forEach(showEventAndParent);
            return;
        }

        var matchingEvents = findMatchingEvents();
        var nonMatchingEvents = Util.arrayDiff(events, matchingEvents);
        matchingEvents.forEach(showEventAndParent);
        nonMatchingEvents.forEach(function(e){
            $(e).hide();
        });


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
