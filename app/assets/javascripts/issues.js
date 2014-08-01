( function() {
    function ready() {
        $('#theses ol').sortable({
            stop: function(event, ui) {
                var $list = $(this),
                    ids = $list.find('li.thesis').map(function() {
                        return $(this).data('id');
                    }).toArray(),
                    url = $list.data('reorder-url'),
                    data = url.indexOf('against') === -1 ? {issue: {thesis_for_ids: ids}} : {issue: {thesis_against_ids: ids}};

                $.ajax({
                    url: url,
                    type: 'PATCH',
                    data: data
                });
            }
        })
        .disableSelection();

        $('[data-toggle="tooltip"]').tooltip();

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
            $activeThesis = $("#forms [data-id=" + $(this).find( 'input[type=radio]:checked' ).val() + "]")
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

