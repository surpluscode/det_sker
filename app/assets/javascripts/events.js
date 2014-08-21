var activeFilters = [];

$(document).ready(function() {
    $('span.event-topbar_js').click(toggleContent);
    $('a.filter-link').click(filterCategory);
    //we need to handle the click on the ul level,
    // because the li elements aren't generated  yet
    $('.show-long-description_js').click(toggleLongDescription);
    $('a[data-target]').on("ajax:success", showEditCommentForm);
    $('[data-toggle="popover"]').popover();

});

/**
 * Hide content box and show the form
 * retrieved from the web request
 * @param event
 * @param xhr
 */
function showEditCommentForm(event, xhr){
    //target div has id equal to the clicked link's data target attr
    var target = $('#' + $(this).attr('data-target'));
    target.html(xhr);
    $(this).parents('div.comment-container_js').hide();
    target.removeClass('hidden');
}

/**
 * When a user clicks on a filter-link
 * hide all events that do not have that category
 * and show filter as active in DOM
 * @returns {boolean}
 */
function filterCategory(){
    var filter = $(this).attr('data-toggle');
    if (activeFilters.indexOf(filter) == -1) {
        activeFilters.push(filter);
    } else if ($(this).hasClass('active')){
        activeFilters.remove(filter);
    }
    refreshFilterView();
    evaluateShown();
    return false;
}

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
                var attributes = $(this).attr('data-toggle').split(' ');
                var parentId = '#' + $(this).attr('data-parent');
                if ($(this).is(':hidden')) {
                    if (attributesMatchFilters(attributes)) {
                        $(this).show();
                        $(parentId).show();
                    }
                } else if ($(this).is(':visible')) {
                    if (!attributesMatchFilters(attributes)) {
                        $(this).hide();
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

    evaluateEventVisibility();
    evaluateDateVisibility();
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
 * has any of the specified categories
 *
 * @param eventCategories
 * @returns {boolean}
 */
function attributesMatchFilters(eventCategories) {
    for (var i = 0; i < activeFilters.length; i++) {
        if (eventCategories.indexOf(activeFilters[i]) >= 0) {
            return true;
        }
    }
    return false;
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
function toggleLongDescription() {
    $(this).hide();
    $(this).siblings('.long-description').slideToggle();
    return false;
}