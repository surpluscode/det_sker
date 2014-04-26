var activeFilters = [];

$(document).ready(function() {
    $('div.event-container').click(toggleContent);
    $('a.filter-link').click(filterCategory);
    //we need to handle the click on the ul level,
    // because the li elements aren't generated  yet
    $('ul.active-filters_js').click(removeFilter);

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
        evaluateShown();
    }
    return false;
}


function removeFilter(event){
    var filter = $(event.target).attr('data-toggle');
    activeFilters.remove(filter);
    updateActiveFilters();
    evaluateShown();
    return false;
}

/**
 * if there is at least one active filter
 * hide all events that do not have a category matching our filters
 * else show all events
 */
function evaluateShown(){
    var events = $('div.event-container');
    if (activeFilters.length == 0) {
        events.show();
        return;
    }

    events.each(function(i){
        var categories = $(this).attr('data-category').split(';');
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
        filterHTML += '<li>' + filterName + removeLink + '</li>';
    }
    $('ul.active-filters_js').html(filterHTML);
}

/**
 *   If this container's details div is exposed, hide it
 *   otherwise, hide any exposed details div and show the
 *   current container's details div.
 */
function toggleContent() {
    if  ($(this).children('.event-details').hasClass('revealed')) {
        $(this).children('.event-details').removeClass('revealed').slideToggle();
    } else {
        $('.revealed').removeClass('revealed').slideToggle();
        $(this).children('.event-details').addClass('revealed').slideToggle();
    }
}
