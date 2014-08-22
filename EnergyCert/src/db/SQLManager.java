package db;

import java.sql.ResultSet;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.io.PrintStream;

public class SQLManager {
		
	public SQLManager() {
		
	}
	
	/*
	static {
		//CREATION OF QUESTIONNAIRE TABLE (data from SiteInfo and SiteUsage)
		String tableName = "QUESTIONNAIRE";
		ArrayList<String> fields = new ArrayList<String>();
		
		fields.add("questionnaire_id varchar(255)");
		fields.add("site_id varchar(255)");
		fields.add("year varchar(255)");
		fields.add("site_info_reference varchar(255)");
		fields.add("site_info_business_unit varchar(255)");	
		fields.add("site_info_leasehold_freehold varchar(255)");
		fields.add("site_info_lease_expire varchar(255)");
		fields.add("site_info_contract_expire varchar(255)");
		fields.add("site_info_contact_name varchar(255)");
		fields.add("site_info_contact_job_title varchar(255)");
		fields.add("site_info_contact_phone varchar(255)");
		fields.add("site_info_contact_email varchar(255)");
		fields.add("site_info_activities_services varchar(255)");
		fields.add("site_info_sustainability_champion varchar(255)");
		fields.add("site_info_reduction_targets varchar(255)");
		fields.add("site_info_targets_level varchar(255)");
		fields.add("site_info_carbon_reduction_targets varchar(255)");
		fields.add("site_info_employee_awareness_program varchar(255)");
		fields.add("site_info_access_to_energy_data varchar(255)");
		fields.add("site_info_truck_loading_bays varchar(255)");
		fields.add("site_info_bays_dock_seals varchar(255)");
		fields.add("ampere_hours varchar(255)");
		fields.add("voltage varchar(255)");
		fields.add("total_charges varchar(255)");
		fields.add("total_charge_duration varchar(255)");	
		fields.add("site_info_ext_area_illuminated varchar(255)");
		fields.add("site_info_hours_area_lit varchar(255)");
		fields.add("site_info_ext_area_controlled varchar(255)");
		fields.add("site_info_office_heating varchar(255)");
		fields.add("site_info_age_heating_system varchar(255)");
		fields.add("site_info_serviced_heating_system varchar(255)");
		fields.add("site_info_length_uninsulated_pipes varchar(255)");
		fields.add("site_info_num_uninsulated_valves varchar(255)");
		fields.add("site_info_hot_water_toilets_washing varchar(255)");
		fields.add("site_info_storage_tank_insulated varchar(255)");
		fields.add("site_info_hot_water_heating_controlled varchar(255)");
		fields.add("site_info_office_cooling varchar(255)");
		fields.add("site_info_cooling_age varchar(255)");
		fields.add("site_info_cooling_serviced varchar(255)");
		fields.add("site_info_warehouse_heating varchar(255)");	
		fields.add("site_info_warehouse_heating_age varchar(255)");
		fields.add("site_info_warehouse_heating_serviced varchar(255)");
		fields.add("site_info_central_fan varchar(255)");
		fields.add("site_info_fan_controlled varchar(255)");
		fields.add("site_info_vol_red_opt_eq varchar(255)");	
		fields.add("site_info_electricity_meter varchar(255)");
		fields.add("site_info_sub_meters varchar(255)");
		fields.add("site_info_initiatives_done varchar(255)");
		fields.add("site_info_initiatives_done_when varchar(255)");
		fields.add("site_info_initiatives_done_zone varchar(255)");
		fields.add("site_info_initiatives_done_impact varchar(255)");
		fields.add("site_info_initiatives_planned varchar(255)");
		fields.add("site_info_initiatives_planned_when varchar(255)");
		fields.add("site_info_initiatives_planned_zone varchar(255)");
		fields.add("site_info_initiatives_planned_impact varchar(255)");
		fields.add("usage_electricity_use varchar(255)");
		fields.add("usage_electricity_use_source varchar(255)");
		fields.add("usage_electricty_cost varchar(255)");
		fields.add("usage_renew_electricity_use varchar(255)");
		fields.add("usage_renew_electricity_use_source varchar(255)");
		fields.add("usage_renew_electricty_cost varchar(255)");
		fields.add("usage_nat_gas_use varchar(255)");
		fields.add("usage_nat_gas_use_source varchar(255)");
		fields.add("usage_nat_gas_cost varchar(255)");
		fields.add("usage_fuel_oil_use varchar(255)");	
		fields.add("usage_fuel_oil_use_source varchar(255)");
		fields.add("usage_fuel_oil_cost varchar(255)");
		fields.add("usage_diesel_use varchar(255)");
		fields.add("usage_diesel_use_source varchar(255)");
		fields.add("usage_diesel_cost varchar(255)");
		fields.add("usage_lpg_use varchar(255)");
		fields.add("usage_lpg_use_source varchar(255)");
		fields.add("usage_lpg_cost varchar(255)");
		fields.add("usage_district_heating_use varchar(255)");	
		fields.add("usage_district_heating_use_source varchar(255)");
		fields.add("usage_district_heating_cost varchar(255)");
		fields.add("usage_district_cooling_use varchar(255)");
		fields.add("usage_district_cooling_use_source varchar(255)");
		fields.add("usage_district_cooling_cost varchar(255)");
		
		String primaryKey = "questionnaire_id";
		SQLManager.createTable(tableName, fields, primaryKey);
		System.out.println("Created table " + tableName);
		
		/*CREATION OF SITE TABLE (data from SiteInfo)
		tableName = "SITE";
		fields = new ArrayList<String>();
		
		fields.add("Questionnaire_ID varchar(255)");
		fields.add("site_info_ext_area_illuminated varchar(255)");
		fields.add("site_info_hours_area_lit varchar(255)");
		fields.add("site_info_name varchar(255)");
		fields.add("site_info_address_street varchar(255)");
		fields.add("site_info_address_city varchar(255)");
		fields.add("site_info_address_postal varchar(255)");
		fields.add("site_info_address_country varchar(255)");
		fields.add("usage_electricity_use varchar(255)");
		
		primaryKey = "questionnaire_id";
		SQLManager.createTable(tableName, fields, primaryKey);
		System.out.println("Created table " + tableName);
		
		
		//Creation of the GROUND_TO_ROOF_FORM table
		tableName = "GROUND_TO_ROOF_FORM";
		fields = new ArrayList<String>();
		
		fields.add("questionnaire_id varchar(255)");
		fields.add("zone_id varchar(255)");
		fields.add("building_num varchar(255)");
		fields.add("zone_num varchar(255)");
		fields.add("building_name char(255)");
		fields.add("zone_name char(255)");
		fields.add("zone_activity char(255)");
		fields.add("zone_heating_cooling char(255)");
		fields.add("zone_min_temp char(10)");
		fields.add("zone_max_temp char(10)");
		fields.add("zone_operation char(10)");
		fields.add("zone_operationalhrs_mon char(10)");
		fields.add("zone_operationalhrs_tues char(10)");
		fields.add("zone_operationalhrs_wed char(10)");
		fields.add("zone_operationalhrs_thurs char(10)");
		fields.add("zone_operationalhrs_fri char(10)");
		fields.add("zone_operationalhrs_sat char(10)");
		fields.add("zone_operationalhrs_sun char(10)");
		fields.add("zone_floorarea char(255)");
		fields.add("zone_zoneprop_narrow char(255)");
		fields.add("zone_zoneprop_wide char(255)");
		fields.add("zone_zoneprop_open char(255)");
		fields.add("zone_height char(255)");
		fields.add("zone_sorting_conveyor char(255)");
		fields.add("zone_ismotordrivenconveyor char(255)");
		fields.add("zone_conveyor_hours char(255)");
		fields.add("zone_conveyor_isturnedoff char(255)");
		fields.add("zone_hasskylights char(255)");
		fields.add("zone_isskylightsufficient char(255)");
		fields.add("zone_isskylightcleaned char(255)");
		fields.add("zone_lighting char(255)");
		fields.add("zone_fluorescent_tube char(255)");
		fields.add("zone_t8_ballasttype char(155)");
		fields.add("zone_powerrating char(255)");
		fields.add("zone_numoflightings char(255)");
		fields.add("zone_lightcontroltype char(255)");
		fields.add("zone_ismanuallyturnedoff char(10)");
		fields.add("zone_hasradiantheaters char(255)");
				
		primaryKey = "zone_id";
		SQLManager.createTable(tableName, fields, primaryKey);
		System.out.println("Created table " + tableName);
		
		//Creation of the OFFICE_FORM table
		tableName = "OFFICE_FORM";
		fields = new ArrayList<String>();
		
		fields.add("questionnaire_id varchar(255)");
		fields.add("zone_id varchar(255)");
		fields.add("building_num varchar(255)");
		fields.add("zone_num varchar(255)");
		fields.add("building_name char(255)");
		fields.add("zone_name char(255)");
		fields.add("zone_activity char(255)");
		fields.add("zone_heating_cooling char(255)");
		fields.add("zone_min_temp char(255)");
		fields.add("zone_max_temp char(255)");
		fields.add("zone_operation char(255)");
		fields.add("zone_operationalhrs_mon char(255)");
		fields.add("zone_operationalhrs_tues char(255)");
		fields.add("zone_operationalhrs_wed char(255)");
		fields.add("zone_operationalhrs_thurs char(255)");
		fields.add("zone_operationalhrs_fri char(255)");
		fields.add("zone_operationalhrs_sat char(255)");
		fields.add("zone_operationalhrs_sun char(255)");
		fields.add("zone_floorarea char(255)");
		fields.add("zone_numoffloors char(255)");
		fields.add("zone_aveemployees char(255)");
		fields.add("zone_numoflaptops char(255)");
		fields.add("zone_numofflatscreen char(255)");
		fields.add("zone_numofCRTmonitor char(255)");
		fields.add("zone_isalwaysshutdown char(255)");
		fields.add("zone_ispowersavingmode char(255)");
		fields.add("zone_lighting char(255)");
		fields.add("zone_fluorescent_tube char(255)");
		fields.add("zone_t8_ballasttype char(255)");
		fields.add("zone_lightcontroltype char(255)");
		fields.add("zone_externalglazingtype char(255)");
				
		primaryKey = "zone_id";
		SQLManager.createTable(tableName, fields, primaryKey);
		System.out.println("Created table " + tableName);
		
		//Creation of the WAREHOUSE_VALUE_ADD_FORM table
		tableName = "WAREHOUSE_VALUE_ADD_FORM";
		fields = new ArrayList<String>();
		
		fields.add("questionnaire_id varchar(255)");
		fields.add("zone_id varchar(255)");
		fields.add("building_num varchar(255)");
		fields.add("zone_num varchar(255)");
		fields.add("building_name char(255)");
		fields.add("zone_name char(255)");
		fields.add("zone_activity char(255)");
		fields.add("zone_heating_cooling char(255)");
		fields.add("zone_min_temp char(255)");
		fields.add("zone_max_temp char(255)");
		fields.add("zone_operation char(255)");
		fields.add("zone_operationalhrs_mon char(255)");
		fields.add("zone_operationalhrs_tues char(255)");
		fields.add("zone_operationalhrs_wed char(255)");
		fields.add("zone_operationalhrs_thurs char(255)");
		fields.add("zone_operationalhrs_fri char(255)");
		fields.add("zone_operationalhrs_sat char(255)");
		fields.add("zone_operationalhrs_sun char(255)");
		fields.add("zone_floorarea char(255)");
		fields.add("zone_numoffloors char(255)");
		fields.add("zone_numofmanualws char(255)");
		fields.add("zone_manualpower char(255)");
		fields.add("zone_numoflightws char(255)");
		fields.add("zone_lightpower char(255)");
		fields.add("zone_numofheavyws char(255)");
		fields.add("zone_heavypower char(255)");
		fields.add("zone_lighting char(255)");
		fields.add("zone_fluorescent_tube char(255)");
		fields.add("zone_t8_ballasttype char(255)");
		fields.add("zone_lightcontroltype char(255)");
		
		primaryKey = "zone_id";
		SQLManager.createTable(tableName, fields, primaryKey);
		System.out.println("Created table " + tableName);
		
		//Creation of the MEZZANINE_FORM table
		tableName = "MEZZANINE_FORM";
		fields = new ArrayList<String>();
		
		fields.add("questionnaire_id varchar(255)");
		fields.add("zone_id varchar(255)");
		fields.add("building_num varchar(255)");
		fields.add("zone_num varchar(255)");
		fields.add("building_name char(255)");
		fields.add("zone_name char(255)");
		fields.add("zone_activity char(255)");
		fields.add("zone_heating_cooling char(255)");
		fields.add("zone_min_temp char(255)");
		fields.add("zone_max_temp char(255)");
		fields.add("zone_operation char(255)");
		fields.add("zone_operationalhrs_mon char(255)");
		fields.add("zone_operationalhrs_tues char(255)");
		fields.add("zone_operationalhrs_wed char(255)");
		fields.add("zone_operationalhrs_thurs char(255)");
		fields.add("zone_operationalhrs_fri char(255)");
		fields.add("zone_operationalhrs_sat char(255)");
		fields.add("zone_operationalhrs_sun char(255)");
		fields.add("zone_floorarea char(255)");
		fields.add("zone_numoffloors char(255)");
		fields.add("zone_zoneprop_narrow char(255)");
		fields.add("zone_zoneprop_wide char(255)");
		fields.add("zone_zoneprop_open char(255)");
		fields.add("zone_lighting char(255)");
		fields.add("zone_fluorescent_tube char(255)");
		fields.add("zone_t8_ballasttype char(255)");
		fields.add("zone_lightcontroltype char(255)");
		fields.add("zone_hasgoodslift char(255)");
		
		primaryKey = "zone_id";
		SQLManager.createTable(tableName, fields, primaryKey);
		System.out.println("Created table " + tableName);
		
		//Creation of the SITE_DEFINITION table
		tableName = "SITE_DEFINITION";
		fields = new ArrayList<String>();
		
		fields.add("questionnaire_id varchar(255)");
		fields.add("site_def_info varchar(1000)");
		fields.add("site_def_activity varchar(1000)");
		fields.add("site_def_building_name varchar(1000)");
		
		primaryKey = "questionnaire_id";
		SQLManager.createTable(tableName, fields, primaryKey);
		System.out.println("Created table " + tableName);
		
		//Creation of the QUESTIONNAIRE_LINK table
		tableName = "QUESTIONNAIRE_LINK";
		fields = new ArrayList<String>();
		
		fields.add("questionnaire_id varchar(255)");
		fields.add("questionnaire_link varchar(255)");
		fields.add("link_timestamp varchar(255)");
		
		primaryKey = "questionnaire_link";
		SQLManager.createTable(tableName, fields, primaryKey);
		System.out.println("Created table " + tableName);
    }
	*/
	
	/*
	Creates a table in the database
	�	tableName � the name of the table
	�	fields � ArrayList of Strings of field details. Each String corresponds to one field�s name and data type
	�	primaryKey � primary key of the table
	*/
	public static void createTable(String tableName, ArrayList<String> fields, String primaryKey){
		
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.createStatement();
            
            String sqlStatement = "DROP TABLE IF EXISTS " + tableName;
    		stmt.executeUpdate(sqlStatement);
    		
    		sqlStatement = "CREATE TABLE " + tableName + "(";
    		for (String field : fields) {
    			sqlStatement += field + ", ";
    		}
    		sqlStatement += "PRIMARY KEY(" + primaryKey + "));";
    		stmt.executeUpdate(sqlStatement);
			
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
		    
	}
	
	/*
	Deletes a table from the database
	�	tableName � the name of the table
	*/
	public static void dropTable(String tableName){
		
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.createStatement();
            
            String sqlStatement = "DROP TABLE " + tableName;
    		stmt.executeUpdate(sqlStatement);
    		
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
		    
	}
	
	/*
	Inserts multiple records into a table
	�	tableName � the name of the table
	�	valuesList � ArrayList of Strings of values. Each String corresponds to one record�s values
	*/
	public static void insertRecords(String tableName, ArrayList<String> valuesList){
		
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.createStatement();
            
            for (String values : valuesList) {
	            String sqlStatement = "INSERT INTO " + tableName + " VALUES (" + values + ")";
	    		stmt.executeUpdate(sqlStatement);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
		    
	}
	
	/*
	Inserts a single record into a table
	�	tableName � the name of the table
	�	values � the record�s values
	*/
	public static void insertRecord(String tableName, String values){
		
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.createStatement();
            
            String sqlStatement = "INSERT INTO " + tableName + " VALUES (" + values + ")";
    		stmt.executeUpdate(sqlStatement);
    		
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
		    
	}
	
	/*
	Retrieves all from the table
	�	tableName � the name of the table
	�	returns an instance of java.sql.ResultSet
	*/
	public static ResultSet retrieveAll(String tableName){
		
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.createStatement();
            
            String sqlStatement = "SELECT * FROM " + tableName;
		    rs = stmt.executeQuery(sqlStatement);
        } catch (SQLException e) {
            e.printStackTrace();
        } /* finally {
            ConnectionManager.close(conn, stmt, rs);
        }*/
        return rs;
		
	}
	
	/*
	Retrieves row count of the table specified
	*/
	public static int getRowCount(String tableName) throws Exception {
		
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        int rowCount = 0;
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.createStatement();
            
            String sqlStatement = "SELECT COUNT(*) FROM " + tableName;
		    rs = stmt.executeQuery(sqlStatement);
		    rs.next();
			rowCount = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
       
		
        return rowCount;
	}
	
	
	/*
	Retrieves specific records (based on where clause) from the table
	�	tableName � the name of the table
	�	whereClause � the condition that is to be met for retrieval
	�	returns an instance of java.sql.ResultSet
	*/
	public static ResultSet retrieveRecords(String tableName, String whereClause){
		
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.createStatement();
            
            String sqlStatement = "SELECT * FROM " + tableName + " WHERE " + whereClause;
		    rs = stmt.executeQuery(sqlStatement);
        } catch (SQLException e) {
            e.printStackTrace();
        } /* finally {
            ConnectionManager.close(conn, stmt, rs);
        }*/
        return rs;
		
	}

	/*
	Updates the value of the specified variable of all records in the table
	�	tableName � the name of the table
	�	toSet � the variable to be set & the value to  set to
	*/
	public static void updateAll(String tableName, String toSet){
		
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.createStatement();
            
            String sqlStatement = "UPDATE " + tableName + " SET " + toSet;
		    stmt.executeUpdate(sqlStatement);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
		
	}
	
	/*
	Updates the value of the specified variable of specific records in the table
	�	tableName � the name of the table
	�	toSet � the variable to be set & the value to  set to
	�	whereClause � the condition that is to be met for updating
	*/
	public static void updateRecords(String tableName, String toSet, String whereClause){
		
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.createStatement();
            
            String sqlStatement = "UPDATE " + tableName + " SET " + toSet + " WHERE " 
            		+ whereClause;
		    stmt.executeUpdate(sqlStatement);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
		
	}
	
	/*
	Deletes all records from the table
	�	tableName � the name of the table
	*/
	public static void deleteAll(String tableName){
		
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.createStatement();
            
            String sqlStatement = "DELETE FROM " + tableName;
		    stmt.executeUpdate(sqlStatement);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
		
	}
	
	/*
	Deletes specific records from the table
	�	tableName � the name of the table
	�	whereClause � the condition that is to be met for retrieval
	*/
	public static void deleteRecords(String tableName, String whereClause){
		
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.createStatement();
            
            String sqlStatement = "DELETE FROM " + tableName + " WHERE " + whereClause;
		    stmt.executeUpdate(sqlStatement);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
		
	}
	
}
