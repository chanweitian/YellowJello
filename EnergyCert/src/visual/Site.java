package visual;

public class Site {
	
	public String siteName;
	public String efficiencyRating;
	public String co2_nat_gas_use;
	public String co2_electricity_use;
	public String nat_gas_use;
	public String electricity_use;
	public String country;
	public String region;
	
	public Site(String siteName, String efficiencyRating, String co2_nat_gas_use, String co2_electricity_use, String nat_gas_use, String electricity_use, String region, String country){
		this.siteName = siteName;
		this.efficiencyRating = efficiencyRating;
		this.co2_electricity_use = co2_electricity_use;
		this.co2_nat_gas_use = co2_nat_gas_use;
		this.nat_gas_use = nat_gas_use;
		this.electricity_use = electricity_use;
		this.region = region;
		this.country = country;
	}
	
	public String siteName(){
		return siteName;
	}
	
	public String efficiencyRating(){
		return efficiencyRating;
	}
	
	public int carbonConsumption(){
		int electricity_carbon = Integer.parseInt(co2_electricity_use);
		int gas_carbon = Integer.parseInt(co2_nat_gas_use);
		return electricity_carbon+gas_carbon;
	}
	
	public int energyConsumption(){
		int electric = Integer.parseInt(electricity_use);
		int gas = Integer.parseInt(nat_gas_use);
		return gas+electric;
	}
	
	public String getRegion(){
		return region;
	}
	
	public String getCountry(){
		return country;
	}
	
}
