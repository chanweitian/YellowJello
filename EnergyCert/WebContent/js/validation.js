$(document).ready(function() {
    $('#questionnaire').bootstrapValidator({
    	
    	feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
    	fields: {
            zonename: {
            	selector: '[id="zone_name"]',
                validators: {
                    notEmpty: {
                        message: 'This field is required'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9]+$/i,
                        message: 'Alphabetical characters <br> & digits only'
                    }
                }
            },
            zonetype: {
            	selector: '[id="zone_type"]',
                validators: {
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            zoneheatingcooling: {
            	selector: '[id="zone_heating_cooling"]',
                validators: {
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            integer: {
            	selector: '[id="integer"]',
                validators: {
                	notEmpty: {
                        message: 'This field is required'
                    },
                    integer: {
                        message: 'Enter an integer'
                    }
                }
            },
            buildingname: {
            	selector: '[id="building_name"]',
                validators: {
                	notEmpty: {
                        message: 'This field is required'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9]+$/i,
                        message: 'Alphabetical characters <br> & digits only'
                    }
                }
            },
            zoneoperation: {
            	selector: '[id="zone_operation"]',
                validators: {
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            }
            
        }
    })
	.on('error.field.bv', function(e, data) {
	    console.log('error.field.bv -->', data);
	})
	.on('success.field.bv', function(e, field, $field) {
		console.log(field, $field, '-->success');
    });
});

$(document).ready(function() {
    $('#main-questionnaire').bootstrapValidator({
    	
    	feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
    	fields: {
            dropdown_required: {
            	selector: '[id="dropdown_required"]',
                validators: {
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            }
            
        }
    })
});


$(document).ready(function() {
    $('#whaifform').bootstrapValidator({
    	
    	feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
    	fields: {
    		heatFac: {
            	selector: '[id="heatFac"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'This must be a number'
                    }
                }
            },
            coolFac: {
            	selector: '[id="coolFac"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'This must be a number'
                    }
                }
            },
            lightFac: {
            	selector: '[id="lightFac"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'This must be a number'
                    }
                }
            }
            
        }
    })
    .on('error.field.bv', function(e, data) {
	    console.log('error.field.bv -->', data);
	    document.getElementById("whatifButton").disabled = true; 
	})
	.on('success.field.bv', function(e, field, $field) {
		console.log(field, $field, '-->success');
		document.getElementById("whatifButton").disabled = false; 
    });
});

$(document).ready(function() {
    $('#payback_form').bootstrapValidator({
    	
    	feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
    	fields: {
            site_id: {
            	group: '.col-md-3',
                validators: {
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            zone_id: {
            	group: '.col-md-3',
                validators: {
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            actual_consumption_electricity: {
            	group: '.col-md-3',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            electricity_cost: {
            	group: '.col-md-3',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            number: {
            	selector: '[id="number"]',
            	validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            integer: {
            	selector: '[id="integer"]',
            	validators: {
            		integer: {
                        message: 'Enter an integer'
                    },
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            required_value: {
            	selector: '[id="required_value"]',
            	validators: { 
                    notEmpty: {
                        message: 'Please select at least one type of lighting for analysis'
                    },
                    callback: {
                        message: 'Please do not select more than 4 types',
                        callback: function(value, validator) {
                            return ($("input:checkbox:checked").length <= 4);
                        }
                    }
                }
            }
            
        }
    })
});

$(document).ready(function() {
	$('#datetimePicker1').datetimepicker({
		pickTime: false
	});
	
	$('#datetimePicker2').datetimepicker({
		pickTime: false
	});
	
    $('#master_form').bootstrapValidator({
    	excluded: [':disabled'],
    	feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
    	fields: {
    		electricity_usage_required: {
            	selector: '[id="electricity_usage_required"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            electricity_cost_required: {
            	selector: '[id="electricity_usage_cost"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            renewable_usage_optional: {
            	selector: '[id="renewable_usage_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            renewable_cost_optional: {
            	selector: '[id="renewable_cost_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            nat_gas_usage_required: {
            	selector: '[id="nat_gas_usage_required"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            nat_gas_cost_required: {
            	selector: '[id="nat_gas_cost_required"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            fuel_oil_usage_optional: {
            	selector: '[id="fuel_oil_usage_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            fuel_oil_cost_optional: {
            	selector: '[id="fuel_oil_cost_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            diesel_usage_optional: {
            	selector: '[id="diesel_usage_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            diesel_cost_optional: {
            	selector: '[id="diesel_cost_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            lpg_usage_optional: {
            	selector: '[id="lpg_usage_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            lpg_cost_optional: {
            	selector: '[id="lpg_cost_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            district_heating_usage_optional: {
            	selector: '[id="district_heating_usage_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            district_heating_cost_optional: {
            	selector: '[id="district_heating_cost_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            district_cooling_usage_optional: {
            	selector: '[id="district_cooling_usage_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            district_cooling_cost_optional: {
            	selector: '[id="district_cooling_cost_optional"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
                    numeric: {
                        message: 'Enter a valid number'
                    }
                }
            },
            numbers: {
            	selector: '[id="numbers"]',
                validators: {
                    notEmpty: {
                        message: 'This field is required'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
                    greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Please enter a value greater than or equals to 0'
                    }
                }
            },
            required_value: {
            	selector: '[id="required_value"]',
                validators: {
                    notEmpty: {
                        message: 'This field is required'
                    },
                    valid_spacing: {
                        message: 'Omit * ^ , and spacing'
                    }
                }
            },
            hours_per_day: {
            	selector: '[id="hours_per_day"]',
                validators: {
                	between: {
                        min: 0,
                        max: 24,
                        message: 'Please enter a number between 0 and 24'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            hours_per_day_mon: {
            	selector: '[id="hours_per_day_mon"]',
                validators: {
                	between: {
                        min: 0,
                        max: 24,
                        message: 'Please enter a number between 0 and 24'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            hours_per_day_tue: {
            	selector: '[id="hours_per_day_tue"]',
                validators: {
                	between: {
                        min: 0,
                        max: 24,
                        message: 'Please enter a number between 0 and 24'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            hours_per_day_wed: {
            	selector: '[id="hours_per_day_wed"]',
                validators: {
                	between: {
                        min: 0,
                        max: 24,
                        message: 'Please enter a number between 0 and 24'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            hours_per_day_thu: {
            	selector: '[id="hours_per_day_thu"]',
                validators: {
                	between: {
                        min: 0,
                        max: 24,
                        message: 'Please enter a number between 0 and 24'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            hours_per_day_fri: {
            	selector: '[id="hours_per_day_fri"]',
                validators: {
                	between: {
                        min: 0,
                        max: 24,
                        message: 'Please enter a number between 0 and 24'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            hours_per_day_sat: {
            	selector: '[id="hours_per_day_sat"]',
                validators: {
                	between: {
                        min: 0,
                        max: 24,
                        message: 'Please enter a number between 0 and 24'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            hours_per_day_sun: {
            	selector: '[id="hours_per_day_sun"]',
                validators: {
                	between: {
                        min: 0,
                        max: 24,
                        message: 'Please enter a number between 0 and 24'
                    },
                    numeric: {
                        message: 'This must be a number'
                    },
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            numbers_opt: {
            	selector: '[id="numbers_opt"]',
                validators: {
                    numeric: {
                        message: 'This must be a number'
                    }
                }
            },
            site_business_unit: {
            	selector: '[id="site_business_unit"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            leasehold_freehold: {
            	selector: '[id="leasehold_freehold"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            
            carbon_reduction_targets: {
            	selector: '[id="carbon_reduction_targets"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            access_to_energy_data: {
            	selector: '[id="access_to_energy_data"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            site_info_ext_area_controlled: {
            	selector: '[id="site_info_ext_area_controlled"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            }, 
            site_info_electricity_meter: {
            	selector: '[id="site_info_electricity_meter"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            site_info_sub_meters: {
            	selector: '[id="site_info_sub_meters"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            lighting: {
            	selector: '[id="lighting"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            pc_monitor_shutdown: {
            	selector: '[id="pc_monitor_shutdown"]',
                validators: {
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            power_savings: {
            	selector: '[id="power_savings"]',
                validators: {
                	notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            zone_office_lighting: {
            	selector: '[id="zone_office_lighting"]',
                validators: {
                	notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            percentage: {
            	selector: '[id="percentage"]',
                validators: {
                	between: {
                        min: 0,
                        max: 100,
                        message: 'Please enter a number between 0 and 100'
                    },
                    integer: {
                        message: 'Enter an integer'
                    },
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            sorting_machine: {
            	selector: '[id="sorting_machine"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            zone_grf_sorting_machine: {
            	selector: '[id="zone_grf_sorting_machine"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            zone_grf_lighting: {
            	selector: '[id="zone_grf_lighting"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            zone_wva_lighting: {
            	selector: '[id="zone_wva_lighting"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            zone_mez_lighting: {
            	selector: '[id="zone_mez_lighting"]',
                validators: {
                    notEmpty: {
                        message: 'The field is required'
                    }
                }
            },
            email: {
            	selector: '[id="email"]',
                validators: {
                    emailAddress: {
                        message: 'The value is not a valid email address'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            email_optional: {
            	selector: '[id="email_optional"]',
                validators: {
                    emailAddress: {
                        message: 'The value is not a valid email address'
                    }
                  
                }
            },
            date: {
            	selector: '[id="date"]',
                validators: {
                    date: {
                        format: 'DD/MM/YYYY',
                        message: 'The value is not a valid date'
                    },
		            notEmpty: {
		                message: 'This field is required'
		            }
                }
            },
            percentage: {
            	selector: '[id="percentage"]',
                validators: {
                	between: {
                        min: 0,
                        max: 100,
                        message: 'Please enter a number between 0 and 100'
                    },
                    integer: {
                        message: 'Enter an integer'
                    },
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            percentage_narrow: {
            	selector: '[id="percentage_narrow"]',
                validators: {
                    integer: {
                        message: 'Enter an integer'
                    },
                    greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive integer'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    },
                    callback: {
                        message: 'The password is not valid',
                        callback: function(value, validator, $field) {
                        	var narrow = parseInt(document.getElementById("percentage_narrow").value);
                        	var wide = parseInt(document.getElementById("percentage_wide").value);
                        	var open = parseInt(document.getElementById("percentage_open").value);
                        	var total = narrow + wide + open;
                        	
                            if (value === '') {
                                return true;
                            }

                            // Check total
                            if (total != 100) {
                                return {
                                    valid: false,
                                    message: 'Total % for Narrow Aisle Racking, Wide Aisle Racking and Open Area must add up to 100'
                                };
                            }
                            return true;
                        }
                    }
                }
            },
            percentage_wide: {
            	selector: '[id="percentage_wide"]',
                validators: {
                    integer: {
                        message: 'Enter an integer'
                    },
                    greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive integer'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    },
                    callback: {
                        message: 'The password is not valid',
                        callback: function(value, validator, $field) {
                        	var narrow = parseInt(document.getElementById("percentage_narrow").value);
                        	var wide = parseInt(document.getElementById("percentage_wide").value);
                        	var open = parseInt(document.getElementById("percentage_open").value);
                        	var total = narrow + wide + open;
                        	
                            if (value === '') {
                                return true;
                            }

                            // Check total
                            if (total != 100) {
                                return {
                                    valid: false,
                                    message: 'Total % for Narrow Aisle Racking, Wide Aisle Racking and Open Area must add up to 100'
                                };
                            }
                            return true;
                        }
                    }
                }
            },
            percentage_open: {
            	selector: '[id="percentage_open"]',
                validators: {
                    integer: {
                        message: 'Enter an integer'
                    },
                    greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive integer'
                    },
                    notEmpty: {
                        message: 'This field is required'
                    },
                    callback: {
                        message: 'The password is not valid',
                        callback: function(value, validator, $field) {
                        	var narrow = parseInt(document.getElementById("percentage_narrow").value);
                        	var wide = parseInt(document.getElementById("percentage_wide").value);
                        	var open = parseInt(document.getElementById("percentage_open").value);
                        	var total = narrow + wide + open;
                        	
                            if (value === '') {
                                return true;
                            }

                            // Check total
                            if (total != 100) {
                                return {
                                    valid: false,
                                    message: 'Total % for Narrow Aisle Racking, Wide Aisle Racking and Open Area must add up to 100'
                                };
                            }
                            return true;
                        }
                    }
                }
            },
            integer_positive_required: {
            	selector: '[id="integer_positive_required"]',
                validators: {
                    integer: {
                        message: 'Enter an integer'
                    },
                    greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Enter a positive number'
                    },
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            date1: {
            	selector: '[id="date1"]',
                validators: {
                    date: {
                        format: 'DD/MM/YYYY',
                        message: 'The value is not a valid date'
                    },
                    callback: {
                        message: 'Enter a date later than current date',
                        callback: function(value, validator) {
                        	if (value=="") {
                        		return true;
                        	}	
                        	 var m = new moment(value, 'DD/MM/YYYY', true);
                             return m.isAfter(moment());
                        }
                    }
                }
            },
            date2: {
            	selector: '[id="date2"]',
                validators: {
                    date: {
                        format: 'DD/MM/YYYY',
                        message: 'The value is not a valid date'
                    },
                    callback: {
                        message: 'Enter a date later than current date',
                        callback: function(value, validator) {
                        	if (value=="") {
                        		return true;
                        	}	
                        	 var m = new moment(value, 'DD/MM/YYYY', true);
                             return m.isAfter(moment());
                        }
                    }
                }
            },
            integer: {
            	selector: '[id="integer"]',
                validators: {
                	notEmpty: {
                        message: 'This field is required'
                    },
                    integer: {
                        message: 'Enter an integer'
                    }
                }
            },
            site_info_truck_loading_bays: {
            	validators: {
                	notEmpty: {
                        message: 'This field is required'
                    },
                    integer: {
                        message: 'Enter an integer'
                    },
                    greaterThan: {
                        value: 0,
                        inclusive: true,
                        message: 'Please enter a value greater than or equals to 0'
                    }
                }
            },
            site_info_bays_dock_seals: {
            	validators: {
                	notEmpty: {
                        message: 'This field is required'
                    },
                    integer: {
                        message: 'Enter an integer'
                    },
                    between: {
                        min: 0,
                        max: 'site_info_truck_loading_bays',
                        message: 'This must be between %s and %s'
                    }
                }
            }
            
        }
    })
        // Called when a field is invalid
    .on('error.field.bv', function(e, data) {
        // data.element --> The field element
        var $tabPane = data.element.parents('.tab-pane'),
            tabId    = $tabPane.attr('id');

        $('a[href="#' + tabId + '"][data-toggle="tab"]')
            .parent()
            .find('span')
            .addClass('glyphicon-remove')
            .removeClass('glyphicon-ok');
        
        var bootstrapValidator = $("#master_form").data('bootstrapValidator');
        bootstrapValidator.disableSubmitButtons(false);
    })

    // Called when a field is valid
    .on('success.field.bv', function(e, data) {
        // data.bv      --> The BootstrapValidator instance
        // data.element --> The field element
    	
        var $tabPane = data.element.parents('.tab-pane'),
            tabId    = $tabPane.attr('id'),
            $icon    = $('a[href="#' + tabId + '"][data-toggle="tab"]')
                        .parent()
                        .find('span')
                        .removeClass('glyphicon-remove glyphicon-ok');
                        //.addClass('glyphicon-ok');
        
        var bootstrapValidator = $("#master_form").data('bootstrapValidator');
        // Check if the submit button is clicked
       // if (bootstrapValidator.getSubmitButton()) {
            // Check if all fields in tab are valid
            var isValidTab = bootstrapValidator.isValidContainer($tabPane);
            //$icon.addClass(isValidTab ? 'glyphicon-ok' : 'glyphicon-remove');
            if (isValidTab) {
            	$icon.addClass('glyphicon-ok');
            } else {
            	$icon.addClass('glyphicon-remove');
            }
       // }
        bootstrapValidator.disableSubmitButtons(false);
    });
    
    $('[name="site_info_truck_loading_bays"]').on('keyup', function() {
        $('#master_form').bootstrapValidator('revalidateField', 'site_info_bays_dock_seals');
    });
    
    $('[id="percentage_narrow"]').on('keyup', function() {
        $('#master_form').bootstrapValidator('revalidateField', 'percentage_wide');
        $('#master_form').bootstrapValidator('revalidateField', 'percentage_open');
    });
    
    $('[id="percentage_wide"]').on('keyup', function() {
        $('#master_form').bootstrapValidator('revalidateField', 'percentage_narrow');
        $('#master_form').bootstrapValidator('revalidateField', 'percentage_open');
    });
    
    $('[id="percentage_open"]').on('keyup', function() {
        $('#master_form').bootstrapValidator('revalidateField', 'percentage_wide');
        $('#master_form').bootstrapValidator('revalidateField', 'percentage_narrow');
    });
    
    $('#datetimePicker1')
    .on('dp.change dp.show', function(e) {
        // Validate the date when user change it
        $('#master_form').bootstrapValidator('revalidateField', 'date1');
    });

	$('#datetimePicker2')
	.on('dp.change dp.show', function(e) {
	    // Validate the date when user change it
	    $('#master_form').bootstrapValidator('revalidateField', 'date2');
	});
    
    
    
});
