/* global Initializers */
Initializers = {
    selectableTheses: function() {
        var $activeThesis;
        $('#theses').on('change', function() {
            if ($activeThesis) $activeThesis.hide();
            $activeThesis = $("#forms [data-id=" + $(this).find( 'input[type=radio]:checked' ).val() + "]");
            $activeThesis.show();
        });
    }
};
(function() {
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


        // toggle editing of issue text
        $('#text .html').click(function() {
            var $text = $(this).parents('#text');
            $text.find('.html').hide();
            $text.find('.edit').show();
        });

        $('#text .cancel').click(function(event) {
            var $text = $(this).parents('#text');
            $text.find('.html').show();
            $text.find('.edit').hide();
            event.preventDefault();
        });


        Initializers.selectableTheses();

        // toggle editing of issue
        $('#forms .thesis').each( function(index, elem) {
            var $elem = $(elem),
                $html = $elem.find('.html'),
                $edit = $elem.find('.edit');

            $html.click(function() {
                $html.hide();
                $edit.show();
            });

            $elem.find('.cancel').click(function(event) {
                $html.show();
                $edit.hide();
            });
        });
    }

    $(ready);
    $(document).on('page:load', ready);
})();
