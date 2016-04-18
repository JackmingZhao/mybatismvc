/*!
 * Build time 2015-06-19
 * Author Jack Zhao
 * Ability: 为select提供搜索功能
 */

(function($) {
	$.widget("custom.combobox", {
		_create: function() {
        	this.wrapper = $("<span>").insertAfter(this.element);
 
        	this.element.hide();
        	this._createAutocomplete();
      	},
 
      	_createAutocomplete: function() {
      		var selected = this.element.children(":selected"), value = $.trim(selected.val()) ? $.trim(selected.text()) : "";
			this.input = $("<input id='_choosefind'>").appendTo(this.wrapper).val(value).attr("title", "").addClass("custom-combobox-input")
				.focus(function() {
					$("#_choosefind").val("");
				})
	          	.autocomplete({
	            	delay: 0,
	            	minLength: 0,
	            	source: $.proxy(this, "_source")
	          	})
	          	.tooltip({
	            	tooltipClass: "ui-state-highlight"
	          	});
 
      		this._on( this.input, {
        		autocompleteselect: function(event, ui) {
        			ui.item.option.selected = true;
      				this._trigger("select", event, {
              			item: $.trim(ui.item.option)
            		});
        		},
 
        		autocompletechange: "_removeIfInvalid"
        	});
			$("#_choosefind").val("-----请选择-----")
    	},
    	
		_source: function(request, response) {
	      	var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
	        response(this.element.children("option").map(function() {
	        	var text = $(this).text();
	          	if (this.value && (!request.term || matcher.test(text)))
		            return {
		              label: text,
		              value: text,
		              option: this
		            };
	        	})
	        );
	    },
 
      	_removeIfInvalid: function(event, ui) {
	        // Selected an item, nothing to do
	        if (ui.item) {
	          return;
	        }
 
	        // Search for a match (case-insensitive)
	        var value = $.trim(this.input.val()),
	          valueLowerCase = value.toLowerCase(),
	          valid = false;
	        this.element.children("option").each(function() {
	          if ($.trim($(this).text().toLowerCase()) === valueLowerCase) {
	            this.selected = valid = true;
	            return false;
	          }
	        });
	 
	        // Found a match, nothing to do
	        if (valid) {
	          return;
	        }
	 
	        // Remove invalid value
	        this.element.val("");
	        this._delay(function() {
	          this.input.tooltip("close").attr("title", "");
	        }, 2500);
      	}
   });
})(jQuery);

