
// Benchmark Parameters 

var L_W_RATIO	= 1.5;
var WINDOW_RATIO = 5;
	
var OFFICE_PARAMS = {6, 0, 1};
var WAREHOUSE_GROUND_TO_ROOF_PARAMS = {0, 1, 0};
var WAREHOUSE_MEZZANINE_PARAMS = {6, 0, 1};
var WAREHOUSE_VALUE_ADD_PARAMS = {6, 0, 1};

var ZONETYPE_PARAMS = {};
ZONETYPE_PARAMS['Office'] = OFFICE_PARAMS;
ZONETYPE_PARAMS['Warehouse Ground to roof'] = WAREHOUSE_GROUND_TO_ROOF_PARAMS;
ZONETYPE_PARAMS['Warehouse Mezzaine'] = WAREHOUSE_MEZZANINE_PARAMS;
ZONETYPE_PARAMS['Warehouse Value'] = WAREHOUSE_VALUE_ADD_PARAMS;


var ROOF_U = 0.15;
var WALL_U = 0.35;
var FLOOR_U = 0.25;
var WINDOWS_U = 0.7;
var OFFICE_AIR_CHANGES_PER_HOUR =	0.3;
var WAREHOUSE_AIR_CHANGES_PER_HOUR = 0.2;
var OFFICE_RADIATOR_EFFICIENCY = 80%;
var WAREHOUSE_BURNER_EFFICIENCY	= 80%;
	
var EXT_LIGHT = 1.2;
	
var WATER_REQ_OFFICE = 0.0413
var WATER_REQ_WAREHOUSE_GROUND_TO_ROOF = 0.0025
var WATER_REQ_WAREHOUSE_MEZZANINE = 0.0413
var WATER_REQ_WAREHOUSE_VALUE_ADD = 0.0413
var TEMP_RISE = 50
var BOILER_SYS_EFFICIENCY = 70%
var SPECIFIC_HEAT_OF_WATER = 0.00418
	
var CONVERSION_FACTOR = 0.0012028
	
var ENERGY_CONSUMPTION_PER_PERSON = 0.13



function getTotalConsumption(){


	var zoneType =  'test'; 		//get zone type
	var area = 0; // get zone area
	var height = 0; 
	var minDegree = 0;
	var maxDegree = 0;
	var hoursPerDay = 0; //get hours per day
	var daysPerWeek = 0; // get days per week
	var numOfPeople = 0;

	var extArea = 0;
	var hoursLitPerWeek = 0; //get hours lit per week

	var MHE = {};
	var MHE['Type 1'] = {};
	var MHE['Type 2'] = {};
	var MHE['Type 3'] = {};

	var heatConsumption = getHeatConsumption();

	var coolingConsumption = getCoolingConsumption();

	var lightingConsumption = getLightingConsumption(zoneType, area, hoursPerDay, daysPerWeek);

	var extLightingConsumption = getExtLightingConsumption(area, hoursLitPerWeek);

	var hotWaterConsumption = getHotWaterConsumption(zoneType, hoursPerDay, daysPerWeek);

	var mheConsumption = getMHE();

	var operationsConsumption = getOperationsConsumption(hoursPerDay, daysPerWeek, numOfPeople);

	return heatConsumption + coolingConsumption + lightingConsumption + extLightingConsumption + hotWaterConsumption = mheConsumption + operationsConsumption;


}





function getHeatConsumption(){

	//get all months kWH with Heat? = "H" and SUM

	return sum;


}

function getCoolingConsumption(){

	//get all months kWH with Heat? = "H" and SUM

	return sum;

}


function getLightingConsumption(zoneType, area, hoursPerDay, daysPerWeek){

	
	var firstParameter = getZoneParameter(zoneType,1);

	var thirdParameter = getZoneParameter(zoneType,3);

	var sum = firstParameter * area * hoursPerDay * daysPerWeek * 52 / 1000 * thirdParameter;

	return sum;

}

function getZoneParameter(zoneType, paramNum){

	var zoneParams = ZONETYPE_PARAMS[zoneType];

	return zoneParams[paramNum-1];
}





function getExtLightingConsumption(area, hoursLitPerWeek){
	
	return EXT_LIGHT * area * hoursLitPerWeek * 52 / 1000;

}

function getHotWaterConsumption(zoneType, hoursPerDay, daysPerWeek){

	var annualAmountOfWater = getAnnualAmountOfWater(zoneType, hoursPerDay, daysPerWeek);

	return annualAmountOfWater * TEMP_RISE * BOILER_SYS_EFFICIENCY * SPECIFIC_HEAT_OF_WATER;

}

function getAnnualAmountOfWater(zoneType, hoursPerDay, daysPerWeek){

	var waterReq = getWaterReq(zoneType);

	return area * waterReq * hoursPerDay * daysPerWeek;
}



function getWaterReq(zoneType){

	switch(zoneType){
		case 'Office':
			return WATER_REQ_OFFICE;
			break;
		case 'Warehouse Ground to Roof':
			return WATER_REQ_WAREHOUSE_GROUND_TO_ROOF;
			break;
		case 'Warehouse Mezzanine':
			return WATER_REQ_WAREHOUSE_MEZZANINE;
			break;
		case 'Warehouse Value Add':
			return WATER_REQ_WAREHOUSE_VALUE_ADD;
			break;
	}



}


function getMHE(){

	var MHEType1Sum = MHE['Type 1'][0] * MHE['Type 1'][1] * MHE['Type 1'][2];
	var MHEType2Sum = MHE['Type 2'][0] * MHE['Type 2'][1] * MHE['Type 2'][2];
	var MHEType3Sum = MHE['Type 3'][0] * MHE['Type 3'][1] * MHE['Type 3'][2];

	return (MHEType1Sum + MHEType2Sum + MHEType3Sum) * CONVERSION_FACTOR * 52 / 1000;

}


function getOperationsConsumption(hoursPerDay, daysPerWeek, numOfPeople){

	return hoursPerDay * daysPerWeek * numOfPeople * 52 * ENERGY_CONSUMPTION_PER_PERSON;

}
















