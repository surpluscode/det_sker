
    $(document).ready(function() {
        $('div.event-container').click(toggleContent);
        $('a.filter-link').click(filterCategory);
    });


    /**
     * When a user clicks on a filter-link
     * hide all events that do not have that category
     * @returns {boolean}
     */
    function filterCategory(){
        var filter = $(this).attr('data-toggle');
        console.log(filter);
        $("div.event-container[data-category!=" + filter +"]").hide();
        return false;
    }

    /*
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
