( function() {
    function ready() {
        $('#theses ol').sortable()
        // {
        //    connectWith: ".connectedSortable"
        //} )
            .disableSelection()

        $('[data-toggle="tooltip"]').tooltip()
        
        $('#text .html').html( markdown.toHTML( $('#text textarea').val() ) )
        
        $('#text').click( function() {
            $(this).find( '.html' ).hide()
            $(this).find( '.edit' ).show()
        } )
    }
    
    $(ready)
    $(document).on( 'page:load', ready )
} )()

