<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Zone Office Form</title>
		
		<link rel="stylesheet" href="css/bootstrap.css"/>
		<link rel="stylesheet" href="css/bootstrapValidator.min.css"/>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/bootstrapValidator.min.js"></script>
	</head>

	<body>
		
		<form id="zof" class="form-horizontal">
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">How many hours per day is this zone typically operational for? (Monday)</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="hours_per_day"/>
		        </div>
		    </div>
		
		    <div class="form-group">
		        <label class="col-lg-5 control-label">How many hours per day is this zone typically operational for? (Tuesday)</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="hours_per_day" />
		        </div>
		    </div>
			
			<div class="form-group">
		        <label class="col-lg-5 control-label">How many hours per day is this zone typically operational for? (Wednesday)</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="hours_per_day" />
		        </div>
		    </div>
		    
			<div class="form-group">
		        <label class="col-lg-5 control-label">How many hours per day is this zone typically operational for? (Thursday)</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="hours_per_day" />
		        </div>
		    </div>
		    
			<div class="form-group">
		        <label class="col-lg-5 control-label">How many hours per day is this zone typically operational for? (Friday)</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="hours_per_day" />
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">How many hours per day is this zone typically operational for? (Saturday)</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="hours_per_day" />
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">How many hours per day is this zone typically operational for? (Sunday)</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="hours_per_day" />
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">What is the total floor area of this zone?</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="numbers" />
		        </div>
		    </div>
		    
		     <div class="form-group">
		        <label class="col-lg-5 control-label">What proportion of this zone is: Narrow Aisle Racking (%)</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="percentage" />
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">What proportion of this zone is: Wide Aisle Racking (%)</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="percentage" />
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">What proportion of this zone is: Open Area (no racking) (%)</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="percentage" />
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">What is the height from the ground to the top of the external wall?</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="numbers" />
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">Does this zone have a sorting machine or conveyor system?</label>
		        <div class="col-lg-3">
		            <div class="radio">
		                <label><input type="radio" name="sorting_machine" value="yes" /> Yes</label>
		            </div>
		            <div class="radio">
		                <label><input type="radio" name="sorting_machine" value="no" /> No</label>
		            </div>
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">//If yes, how many meters of motor driven conveyors are installed? </label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="numbers_opt" />
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">//How many hours per week do these conveyors run? </label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="numbers_opt" />
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">//Are conveyors turned off when no goods are in the system?</label>
		        <div class="col-lg-3">
		            <div class="radio">
		                <label><input type="radio" name="is_conveyors_off" value="yes" /> Yes</label>
		            </div>
		            <div class="radio">
		                <label><input type="radio" name="is_conveyors_off" value="no" /> No</label>
		            </div>
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">//Does this zone have warehouse roof skylights?</label>
		        <div class="col-lg-3">
		            <div class="radio">
		                <label><input type="radio" name="has_roof_skylights" value="yes" /> Yes</label>
		            </div>
		            <div class="radio">
		                <label><input type="radio" name="has_roof_skylights" value="no" /> No</label>
		            </div>
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">//Do the skylights provide sufficient daylight to light this warehouse zone?</label>
		        <div class="col-lg-3">
		            <div class="radio">
		                <label><input type="radio" name="sufficient_skylight" value="yes" /> Yes</label>
		            </div>
		            <div class="radio">
		                <label><input type="radio" name="sufficient_skylight" value="no" /> No</label>
		            </div>
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">//Are the skylights regulary cleaned?</label>
		        <div class="col-lg-3">
		            <div class="radio">
		                <label><input type="radio" name="skylights_cleaned" value="yes" /> Yes</label>
		            </div>
		            <div class="radio">
		                <label><input type="radio" name="skylights_cleaned" value="no" /> No</label>
		            </div>
		        </div>
		    </div>
			
			<div class="form-group">
	            <label class="col-lg-5 control-label">What is the main type of lighting installed?</label>
	            <div class="col-lg-3">
	                <select class="form-control" name="lighting">
	                    <option value="">-- Select one --</option>
	                    <option value="led">LED</option>
	                    <option value="hal">Halogen</option>
	                    <option value="flu">Fluorescent tube</option>
	                    <option value="others">Others</option>
	                </select>
	            </div>
            </div>
            
            <div class="form-group">
	            <label class="col-lg-5 control-label">//If fluoresent what are the main type of tubes are installed? </label>
	            <div class="col-lg-3">
	                <select class="form-control" name="fluoresent_tube_installed">
	                    <option value="">-- Select one --</option>
	                    <option value="t12">T12</option>
	                    <option value="t8">T8</option>
	                    <option value="t5">T5</option>
	                    <option value="compact">Compact</option>
	                </select>
	            </div>
            </div>
            
            <div class="form-group">
	            <label class="col-lg-5 control-label">//If T8 tubes are used, what type of ballast is installed? </label>
	            <div class="col-lg-3">
	                <select class="form-control" name="ballast">
	                    <option value="">-- Select one --</option>
	                    <option value="mag/wirewound">Magnetic/Wire wound</option>
	                    <option value="elec/highfreq">Electronic/High frequency</option>
	                </select>
	            </div>
            </div>
            
            <div class="form-group">
		        <label class="col-lg-5 control-label">What is the power rating of each fitting in this zone's main warehouse lighting system?</label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="numbers_opt" />
		        </div>
		    </div>
            
            <div class="form-group">
		        <label class="col-lg-5 control-label">Approximately how many lighting fittings make up this zone's main lighting system? </label>
		        <div class="col-lg-3">
		            <input type="text" class="form-control" name="numbers_opt" />
		        </div>
		    </div>
            
            <div class="form-group">
	            <label class="col-lg-5 control-label">What type of control is used on this zone's main warehouse lighting system?</label>
	            <div class="col-lg-3">
	                <select class="form-control" name="wh_light_control">
	                    <option value="">-- Select a country --</option>
	                    <option value="manual">Manual</option>
	                    <option value="occ">Occupancy</option>
	                    <option value="daysens">Daylight Sensors</option>
	                </select>
	            </div>
            </div>
            
            <div class="form-group">
		        <label class="col-lg-5 control-label">//If manual, are the lights turned off if there is natural daylight or during non-working time?</label>
		        <div class="col-lg-3">
		            <div class="radio">
		                <label><input type="radio" name="manual_lights_off" value="yes" /> Yes</label>
		            </div>
		            <div class="radio">
		                <label><input type="radio" name="manual_lights_off" value="no" /> No</label>
		            </div>
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-lg-5 control-label">//Is part or all of this zone heated with radiant heaters?</label>
		        <div class="col-lg-3">
		            <div class="radio">
		                <label><input type="radio" name="radiant_heaters" value="yes" /> Yes</label>
		            </div>
		            <div class="radio">
		                <label><input type="radio" name="radiant_heaters" value="no" /> No</label>
		            </div>
		        </div>
		    </div>
            
		    <div class="form-group">
		        <div class="col-md-offset-3 col-md-8">
		            <button type="submit" class="btn btn-primary">Lock it in</button>
		        </div>
		    </div>
		    
		</form>
		
		<script>
			$(document).ready(function() {
			    $('#questionnaire').bootstrapValidator({
			    	feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
			    	fields: {
			            numbers: {
			                validators: {
			                    notEmpty: {
			                        message: 'The field is required and cannot be empty'
			                    },
			                    greaterThan: {
			                        value: 0,
			                        inclusive: false,
			                        message: 'Please enter a number greater than 0'
			                    }
			                }
			            },
			            hours_per_day: {
			                validators: {
			                	between: {
			                        min: 0,
			                        max: 24,
			                        message: 'Please enter a number between 0 and 24'
			                    },
					            notEmpty: {
			                        message: 'This field is required and cannot be empty'
			                    }
			                }
			            },
			            numbers_opt: {
			                validators: {
			                	greaterThan: {
			                        value: 0,
			                        inclusive: false,
			                        message: 'Please enter a digit greater than 0'
			                    }
			                }
			            },
			            percentage: {
			                validators: {
			                	between: {
			                        min: 0,
			                        max: 100,
			                        message: 'Please enter a number between 0 and 100'
			                    },
					            notEmpty: {
			                        message: 'This field is required and cannot be empty'
			                    }
			                }
			            },
			            sorting_machine: {
			                validators: {
			                    notEmpty: {
			                        message: 'The field is required and cannot be empty'
			                    }
			                }
			            },
			            lighting: {
			                validators: {
			                    notEmpty: {
			                        message: 'The field is required and cannot be empty'
			                    }
			                }
			            }
			            
			        },
			        submitHandler: function(validator, form, submitButton) {
			            var fullName = [validator.getFieldElements('hours_per_day').val(),
			                            validator.getFieldElements('numbers').val()].join(' ');
			            $('#helloModal')
			                .find('.modal-title').html('Hello ' + fullName).end()
			                .modal();
			        }
			    });
			});
		</script>
	</body>
</html>