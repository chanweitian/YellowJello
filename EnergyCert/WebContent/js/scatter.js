/**
 * v1.0 
 * Pie Chart Class extends Chart interface
 * Author: Ms Seah 
 * Last Edit: 4/7/14
 */

	
	function Scatter(element, options) {
		this.element = element,
		this.options = options;
		this.init();
		
	}
		Scatter.prototype.init = function(){
			width = this.options.width || 720, 
			height = this.options.height || 400, 
			oMargin = this.options.margin;
			
			//default margin
			var margin = {
					top : 50,
					right : 20,
					bottom : 50,
					left : 50
			};
			
			//update default margin with those stated in options
			//margin = Chart.prototype.mixin(margin, oMargin);
			
			//amend width & height with margins
			this.width = width - margin.right,
			this.height = height - margin.top - margin.bottom;
			
			//update the amended width & height within options
			this.options.width = width, 
			this.options.height = height,
			this.options.margin = margin;
			console.log(this.options.color);
			this.options.color = d3.scale.category10();
			
			this.x = d3.scale.linear()
		    	.range([0, width]);
			
			this.y = d3.scale.linear()
		    	.range([height, 0]);
		
			this.xAxis = d3.svg.axis()
			    .scale(this.x)
			    .orient("bottom");
		
			this.yAxis = d3.svg.axis()
			    .scale(this.y)
			    .orient("left");
			

			this.svg = d3.select(this.element).append("svg")
			    .attr("width", width + margin.left + margin.right)
			    .attr("height", height + margin.top + margin.bottom)
			    .append("g")
			    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
			return this;
		};
		
		Scatter.prototype.render = function(data) {
			x = this.x,
			y = this.y,
			svg = this.svg,
			xAxis = this.xAxis,
			yAxis = this.yAxis,
			yValue = this.options.yValue || '', 
			xValue = this.options.xValue || '',
			color = this.options.color,
			series = this.options.series;
			this.data = data;
			
			console.log(this.options.color);
			var self = this;
			console.log(self.options.color);
			
			x.domain(d3.extent(data, function(d) { return d[xValue]; })).nice();
			y.domain(d3.extent(data, function(d) { return d[yValue]; })).nice();
	
			svg.append("g")
			  .attr("class", "x axis")
			  .attr("transform", "translate(0," + height + ")")
			  .call(xAxis);
			  
			svg.append("g")
		      .attr("class", "y axis")
		      .call(yAxis);
		      
	        svg.selectAll(".dot")
		      .data(data)
		      .enter()
		      .append("circle")
		      .attr("class", "dot")
		      .attr("r", 3.5)
		      .attr("cx", function(d) { return x(d[xValue]); })
		      .attr("cy", function(d) { return y(d[yValue]); })
		      .style("fill", function(d) { return self.options.color(d[series]); })
		      .on("mouseover", function(d) {
		    	  this.tooltip.transition()
	               .duration(200)
	               .style("opacity", 0.7);
		    	  this.tooltip.html(d[series] + "<br/> (" + d[xValue]
		        + ", " + d[yValue] + ")")
	               .style("left", (d3.event.pageX + 5) + "px")
	               .style("top", (d3.event.pageY - 28) + "px");}).on("mouseout", function(d) {
		    	  this.tooltip.transition()
		           .duration(500)
		           .style("opacity", 0);});
	        console.log('rendered ddddd');
	        return this;
		};
		
		Scatter.prototype.clear = function() {
			d3.select('#chart').selectAll('svg').remove();
		};
		
		Scatter.prototype.tooltip = 
			d3.select("#chart").append("div")
		    .attr("class", "tooltip")
		    .style("opacity", 0);
		
		Scatter.prototype.legend = function() {
			var legend = svg.selectAll(".legend")
		      .data(this.options.color.domain())
		      .enter().append("g")
		      .attr("class", "legend")
		      .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });
		
			legend.append("rect")
		      .attr("x", this.options.width - 18)
		      .attr("width", 18)
		      .attr("height", 18)
		      .style("fill", this.options.color);
		
			legend.append("text")
		      .attr("x", this.options.width - 24)
		      .attr("y", 9)
		      .attr("dy", ".35em")
		      .style("text-anchor", "end")
		      .text(function(d) { return d; });
		};
		
		Scatter.prototype.title = function(titleText) {
			svg.append("text")
			.attr("class", "chartTitle")
	        .attr("x", (this.options.width / 2))             
	        .attr("y", 0 - (this.options.margin.top / 2))
	        .attr("text-anchor", "middle")
	        .text(titleText);
		};
		
		Scatter.prototype.xlabel = function(xLabel) {
			svg.append("text")
			  .attr("class", "axisLabel")
			  .attr("x", this.options.width/2)
			  .attr("y", (this.options.height + 35))
			  .text(xLabel);
		};
		
		Scatter.prototype.ylabel = function(yLabel) {
			svg.append("text")
		      .attr("class", "axisLabel")
		      .attr("transform", "rotate(-90)")
		      .attr("dy", 15 - this.options.margin.left)
		      .attr("dx", -(this.options.height - this.options.margin.top) /2)
		      .text(yLabel);
		};