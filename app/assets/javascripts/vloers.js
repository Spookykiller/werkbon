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

    // Project naam & project nummer
    $.post( "http://www.de4gees.nl/AFAS-ProfitClass-PHP-master/sample/sample_AppConnectorGet.php", function( data ) {
        var arr = data;
        var lang = [];
        var project_nummer = [];
        var obj = JSON.parse(arr);
        $.each(obj, function() {
            lang.push(this['Description'])
            project_nummer.push(this['ProjectId'])
        });
        
        // Project naam
        $("#vloer_project_naam").autocomplete({
            source: lang,
            select: function(event, ui) {
                var item_value = (ui.item.value);
                getSibDat(obj, 'Description', item_value, ['ProjectGroup', 'CheckedOut', 'DebtorId', 'ProjectId']);
            }
        });
        
        // Project nummer
        $("#vloer_project_nummer").autocomplete({
            source: project_nummer,
            select: function(event, ui) {
                var item_value = (ui.item.value);
                getSibDatId(obj, 'ProjectId', item_value, ['ProjectGroup', 'CheckedOut', 'DebtorId', 'Description']);
            }
        });
                
    }).fail(function(fail) {
        alert('Oeps, er is iets mis gegaan met het ophalen van projecten!'); // or whatever
    });
    
    // Leverancier
    $.post( "http://www.de4gees.nl/AFAS-ProfitClass-PHP-master/sample/leverancier_AppConnectorGet.php", function( data ) {
        
        var arr = data;
        var lang = [];
        var obj = JSON.parse(arr);
        $.each(obj, function() {
            lang.push(this['CreditorName'])
        });

        $(".leverancier_input").autocomplete({
            source: lang
        });
                
    }).fail(function() {
        alert('Oeps, er is iets mis gegaan met het ophalen van leveranciers!'); // or whatever
    });
    
    
    // Naam klant
    $.post( "http://www.de4gees.nl/AFAS-ProfitClass-PHP-master/sample/debtor_AppConnectorGet.php", function( data2 ) {
        var arr = data2;
        var lang = [];
        var obj = JSON.parse(arr);
        $.each(obj, function() {
            lang.push(this['DebtorName'])
        });

        $("#vloer_naam").autocomplete({
            source: lang,
            select: function(event, ui) {
                var item_value = (ui.item.value);
                getSibDatKlant(obj, 'DebtorName', item_value, ['SearchName', 'AdressLine1', 'AdressLine3', 'AdressLine4', 'DebtorId', 'Email', 'TelNr']);
            }
        });
                
    }).fail(function() {
        alert('Oeps, er is iets mis gegaan met het ophalen van leveranciers!'); // or whatever
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

function getSibDat(obj, key, value, ukKeys) {
    for (var i = 0; i < obj.length; i++) {
        if (obj[i][key] == value) {
            var dat = [];
            for (var x = 0; x < ukKeys.length; x++) {
                dat.push(obj[i][ukKeys[x]]);
            }
            var DebtorId = (dat[2]);
            $("#vloer_project_nummer").val(dat[3]);
            
            $.post( "http://www.de4gees.nl/AFAS-ProfitClass-PHP-master/sample/debtor_AppConnectorGet.php", function( data2 ) {
                var obj2 = JSON.parse(data2);
                getSibDatDebtor(obj2, 'DebtorId', DebtorId, ['SearchName', 'AdressLine1', 'AdressLine3', 'AdressLine4', 'DebtorName', 'Email', 'TelNr']);
            });
        }
    }
}

function getSibDatId(obj, key, value, ukKeys) {
    for (var i = 0; i < obj.length; i++) {
        if (obj[i][key] == value) {
            var dat = [];
            for (var x = 0; x < ukKeys.length; x++) {
                dat.push(obj[i][ukKeys[x]]);
            }
            var DebtorId = (dat[2]);
            $("#vloer_project_naam").val(dat[3]);
            
            $.post( "http://www.de4gees.nl/AFAS-ProfitClass-PHP-master/sample/debtor_AppConnectorGet.php", function( data2 ) {
                var obj2 = JSON.parse(data2);
                getSibDatDebtor(obj2, 'DebtorId', DebtorId, ['SearchName', 'AdressLine1', 'AdressLine3', 'AdressLine4', 'DebtorName', 'Email', 'TelNr']);
            });
        }
    }
}

function getSibDatKlant(obj, key, value, ukKeys) {
    for (var i = 0; i < obj.length; i++) {
        if (obj[i][key] == value) {
            var dat2 = [];
            for (var x = 0; x < ukKeys.length; x++) {
                dat2.push(obj[i][ukKeys[x]]);
            }
            if (dat2[3] == null) {
                dat2[3] = "Nederland";
            }
            var DebtorId = (dat2[4]);
            $("#vloer_AdressLine1").val(dat2[1]);
            $("#vloer_AdressLine3").val(dat2[2]);
            $("#vloer_AdressLine4").val(dat2[3]);
            $("#vloer_email").val(dat2[5]);
            $("#vloer_telefoon").val(dat2[6]);

            $.post( "http://www.de4gees.nl/AFAS-ProfitClass-PHP-master/sample/sample_AppConnectorGet.php", function( data ) {
                var obj = JSON.parse(data);
                getSibDatKlantInfo(obj, 'DebtorId', DebtorId, ['ProjectId', 'Description']);
            });
        }
    }
}

function getSibDatDebtor(obj2, key, value, ukKeys) {
    for (var i = 0; i < obj2.length; i++) {
        if (obj2[i][key] == value) {
            var dat2 = [];
            for (var x = 0; x < ukKeys.length; x++) {
                dat2.push(obj2[i][ukKeys[x]]);
            }
            if (dat2[3] == null) {
                dat2[3] = "Nederland"
            }
            $("#vloer_AdressLine1").val(dat2[1]);
            $("#vloer_AdressLine3").val(dat2[2]);
            $("#vloer_AdressLine4").val(dat2[3]);
            $("#vloer_naam").val(dat2[4]);
            $("#vloer_email").val(dat2[5]);
            $("#vloer_telefoon").val(dat2[6]);
        }
    }
}

function getSibDatKlantInfo(obj, key, value, ukKeys) {
    for (var i = 0; i < obj.length; i++) {
        if (obj[i][key] == value) {
            var dat = [];
            for (var x = 0; x < ukKeys.length; x++) {
                dat.push(obj[i][ukKeys[x]]);
            }
            $("#vloer_project_nummer").val(dat[0]);
            $("#vloer_project_naam").val(dat[1]);
        }
    }
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
        
        if (value == "Vloeren") {
            $('.calculation').hide();
        } else {
            $('.calculation').show();
        }
        
        if (value != 'Gordijnen/vouwgordijnen') {
            $('.gordijnen').hide();
        } else {
            $('.gordijnen').show();
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

    $('.calculation').show();

    $('.gordijnen').hide();

    $('.vouwgordijnen').hide();

    $('.raam').hide();

    switch(value) {
        case 'Vloeren':
            $('.calculation').hide();
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
