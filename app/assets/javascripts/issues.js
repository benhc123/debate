( function() {
    function ready() {
        $('#theses ol').sortable()
        // {
        //    connectWith: ".connectedSortable"
        //} )
            .disableSelection()

        $('[data-toggle="tooltip"]').tooltip()
        
        var text = $('#text textarea').val()
        $('#text .html').html( text.length == 0 ? '+' : markdown.toHTML( text ) )
        
        $('#text .html').click( function() {
            var $text = $(this).parents( '#text' )
            $text.find( '.html' ).hide()
            $text.find( '.edit' ).show()
        } )

        $('#text .cancel').click( function( event ) {
            var $text = $(this).parents( '#text' )
            console.log( 'click', $text.find( '.html' ) )
            $text.find( '.html' ).show()
            $text.find( '.edit' ).hide()
            event.preventDefault()
        } )

        var $activeThesis
        $('#theses').on( 'change', function() {
            if( $activeThesis ) {
                $activeThesis.hide()
            }
            $activeThesis = $("[data-id=" + $(this).find( 'input[type=radio]:checked' ).val() + "]")
            $activeThesis.show()
        } )
    }
    
    $(ready)
    $(document).on( 'page:load', ready )
} )()

