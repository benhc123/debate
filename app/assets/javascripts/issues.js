( function() {
    function ready() {
        $('#theses ol').sortable()
        // {
        //    connectWith: ".connectedSortable"
        //} )
            .disableSelection()

        $('[data-toggle="tooltip"]').tooltip()
        
        if( $('#text').size() > 0 ) {
            var text = $('#text textarea').val()
            $('#text .html').html( ( text && text.length == 0 ) ? '+' : markdown.toHTML( text ) )
        
            $('#text .html').click( function() {
                var $text = $(this).parents( '#text' )
                $text.find( '.html' ).hide()
                $text.find( '.edit' ).show()
            } )
            
            $('#text .cancel').click( function( event ) {
                var $text = $(this).parents( '#text' )
                $text.find( '.html' ).show()
                $text.find( '.edit' ).hide()
                event.preventDefault()
            } )
        }

        var $activeThesis
        $('#theses').on( 'change', function() {
            if( $activeThesis ) {
                $activeThesis.hide()
            }
            $activeThesis = $("[data-id=" + $(this).find( 'input[type=radio]:checked' ).val() + "]")
            $activeThesis.show()
        } )

        $('#forms .thesis').each( function( index, elem ) {
            var $html = $(elem).find( '.html' )
            var $edit = $(elem).find( '.edit' )

            $html.find( '.text' ).html( markdown.toHTML( $(elem).find( 'textarea' ).val() ) )

            $html.click( function() {
                $html.hide()
                $edit.show()
            } )

            $(elem).find( '.cancel' ).click( function( event ) {
                $html.show()
                $edit.hide()
            } )
        } )
    }
    
    $(ready)
    $(document).on( 'page:load', ready )
} )()

