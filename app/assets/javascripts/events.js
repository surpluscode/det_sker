var activeFilters = [];


$(document).ready(function() {
    $('span.event-topbar_js').click(toggleContent);
    $('a.filter-link').click(filterCategory);
    //we need to handle the click on the ul level,
    // because the li elements aren't generated  yet
    $('ul.active-filters_js').click(removeFilter);
    $('.show-long-description_js').click(toggleLongDescription);

});



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
        updateActiveFilters();
    }
    evaluateShown();
    return false;
}


function removeFilter(event){
    var filter = $(event.target).attr('data-toggle');
    activeFilters.remove(filter);
    updateActiveFilters();
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
        var events = $('div.event-container');
        if (activeFilters.length == 0) {
            events.show();
        } else {
            events.each(function (i) {
                var categories = $(this).attr('data-category').split(' ');
                if ($(this).is(':hidden')) {
                    if (categoriesMatchFilters(categories)) {
                        $(this).show();
                    }
                } else if ($(this).is(':visible')) {
                    if (!categoriesMatchFilters(categories)) {
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
        $('.events-by-date_js').each(function (i) {
            var childEvents = $(this).children('div.event-container');
            if (hasVisibleChildEvents(childEvents)) {
                $(this).prev('h2').show();
            } else {
                $(this).prev('h2').hide();
            }
        });
    }

    function evaluateActiveFilterHeader() {
        var header =  $('.active-filter-header_js');
        if (activeFilters.length == 0) {
           header.hide();
        } else {
            header.show();
        }
    }
    evaluateEventVisibility();
    evaluateDateVisibility();
    evaluateActiveFilterHeader();
}

/**
 * Search all given events and return true
 * if any of them are visible
 * @param childEvents
 * @returns {boolean}
 */
function hasVisibleChildEvents(childEvents) {
    var visible = false;
    $(childEvents).each(function(i) {
        if ($(this).is(':visible')) {
            visible = true;
            return false; //return false to break out of the each loop
        }
    });
    return visible;
}

/**
 * This function checks to see if an
 * event has all the necessary categories
 *
 * @param eventCategories
 * @returns {boolean}
 */
function categoriesMatchFilters(eventCategories) {
    for (var i = 0; i < activeFilters.length; i++) {
        if (eventCategories.indexOf(activeFilters[i]) == -1) {
            return false;
        }
    }
    return true;
}

/**
* Given a change in filter state
* Ensure that currently active filters
 * are represented in the DOM
*/
function updateActiveFilters(){
    var filterHTML = '';
    for (var i = 0; i < activeFilters.length; i++) {
        var filterName = activeFilters[i];
        var removeLink = ' <a href="" class="remove-filter" data-toggle="' + filterName + '"> [X] </a>';
        filterHTML += '<li>' + filterName.titleize() + removeLink + '</li>';
    }
    $('ul.active-filters_js').html(filterHTML);
}

/**
 *   If this container's details div is exposed, hide it
 *   otherwise, hide any exposed details div and show the
 *   current container's details div.
 */
function toggleContent() {
    if  ($(this).siblings('.event-details').hasClass('revealed')) {
        $(this).siblings('.event-details').removeClass('revealed').slideToggle();
    } else {
        $('.revealed').removeClass('revealed').slideToggle();
        $(this).siblings('.event-details').addClass('revealed').slideToggle();
    }
}
function toggleLongDescription() {
    $(this).hide();
    $(this).siblings('.long-description').slideToggle();
    return false;
}