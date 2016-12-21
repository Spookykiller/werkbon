$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  request = "test";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

$(document).on('turbolinks:load', function() {
    $('input').click(function(){
	    $(this).select();
        update_subtotal();
        selected_values();
    });
    
    update_subtotal();
    selected_values();
    
    $("input:radio[name=printstyle]").click(function() {
        var value = $(this).val();
        if (value == 'geel') {
            $('#werkbon_totale_prijs').css('color', 'white');
            $('.item_artikel_prijs').css('color', 'white');
            $('.item_totaal_prijs').css('color', 'white');
            $('.item_totaal_arbeid').css('color', 'white');
        } else {
            $('.item_artikel_prijs').css('color', 'black');
            $('.item_totaal_prijs').css('color', 'black');
            $('.item_totaal_arbeid').css('color', 'black');
            $('#werkbon_totale_prijs').css('color', 'black');
        }
    });
    
    $("#datepicker").datepicker({ dateFormat: 'dd/mm/yy' });
    $("#datepicker1").datepicker({ dateFormat: 'dd/mm/yy' });
    
    getWerkbonTypeAfter();
    getWerkbonType();
    
    $('table').on('cocoon:after-insert', function(e, insertedItem){
        $('input').click(function(){
	        $(this).select();
	        update_subtotal();
        });
        getWerkbonTypeAfter();
        update_subtotal();
    });

});

function selected_values() {
    var price = 0;
    $('select').change(function(){
        var row = $(this).closest('tr.row');
        
        $(row).find('select').each(function(x){
            if (!isNaN(Number($('option:selected', this).attr('id'))))  {
                price = price + Number($('option:selected', this).attr('id'));
            }
        });
        $(row).find('.item_artikel_prijs').val(Number(price).toFixed(2));
        price = 0;
    });
}

function update_subtotal() {
    
    var subtotal = 0;
    var price = 0;
    $('.row:visible').each(function(i){
        var prijs = Number($(this).find('.item_artikel_prijs').val());
        var hoeveelheid = Number($(this).find('.item_hoeveelheid').val());
        
        var totaal_prijs = Number(hoeveelheid) * Number(prijs);
        $(this).find('.item_totaal_prijs').val(totaal_prijs.toFixed(2));
        
        if (!isNaN(totaal_prijs)) subtotal += Number(totaal_prijs);
    });
    
    $('#werkbon_totale_prijs').val(subtotal.toFixed(2));
    
}

function getWerkbonType() {
    
    $('#vloer_werkbon_type').change(function(){
        var value = $(this).val()
        var item = $('#item_werkbon_type').val();
        
        $('tr.row').each(function () {
            item = $(this).find('#item_werkbon_type').val();
            if (item != value) {
                $(this).hide();
            }
            if (item == value) {
                $(this).show();
            }
        });
        
        if (value != "Vloeren") {
            $('.vloeren').hide();
        } else {
            $('.vloeren').show();
        }
        
        if (value != 'Gordijnen') {
            $('.gordijnen').hide();
        } else {
            $('.gordijnen').show();
        }
        
        if (value != 'Vouwgordijnen') {
            $('.vouwgordijnen').hide();
        } else {
            $('.vouwgordijnen').show();
        }
        
        if (value != 'Raamdecoratie') {
            $('.raam').hide();
        } else {
            $('.raam').show();
        }
    
        update_subtotal();
    });
    
}

function getWerkbonTypeAfter() {
    var value = $('#vloer_werkbon_type').val();

    $('.vloeren').hide();

    $('.gordijnen').hide();

    $('.vouwgordijnen').hide();

    $('.raam').hide();

    switch(value) {
        case 'Vloeren':
            $('.vloeren').show();
            break;
        case 'Gordijnen':
            $('.gordijnen').show();
            break;
        case 'Vouwgordijnen':
            $('.vouwgordijnen').show();
            break;
        case 'Raamdecoratie':
            $('.raam').show();
            break;
    }
}

function printpage() {
    window.print();
}
