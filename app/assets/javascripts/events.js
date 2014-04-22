
    $(document).ready(function() {
        $('div.event-container').click(toggleContent);

    });

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
