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
    $('#createQuestionnaire').bootstrapValidator({
    	
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
                        message: 'Please select a warehouse to proceed'
                    }
                }
            }
            
        }
    })
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
                	notEmpty: {
                        message: 'This field is required'
                    },
                    integer: {
                        message: 'Enter a valid number'
                    }
                }
            },
            electricity_usage_optional: {
            	selector: '[id="electricity_usage_optional"]',
                validators: {
                    integer: {
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
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            numbers_opt: {
            	selector: '[id="numbers_opt"]',
                validators: {
                	greaterThan: {
                        value: 0,
                        inclusive: false,
                        message: 'Please enter a digit greater than 0'
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
            	selector: '[id="sorting_machine"]',
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
		            notEmpty: {
                        message: 'This field is required'
                    }
                }
            },
            valid_date: {
            	selector: '[id="valid_date"]',
                validators: {
                    date: {
                        format: 'MM/DD/YYYY',
                        message: 'This is not a valid date'
                    }
                }
            }
            
        }
    })
    .on('error.field.bv', function(e, data) {
	    console.log('error.field.bv -->', data);
	    var bootstrapValidator = $("#master_form").data('bootstrapValidator');
    	bootstrapValidator.disableSubmitButtons(false);
	})
	.on('success.field.bv', function(e, field, $field) {
		console.log(field, $field, '-->success');
		var bootstrapValidator = $("#master_form").data('bootstrapValidator');
    	bootstrapValidator.disableSubmitButtons(false);
    })
    .on('status.field.bv', function(e, data) {
    	var bootstrapValidator = $("#master_form").data('bootstrapValidator');
    	bootstrapValidator.disableSubmitButtons(false);
    });
    
    
    
});
