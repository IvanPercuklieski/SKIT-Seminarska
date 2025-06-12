/*
   Licensed to the Apache Software Foundation (ASF) under one or more
   contributor license agreements.  See the NOTICE file distributed with
   this work for additional information regarding copyright ownership.
   The ASF licenses this file to You under the Apache License, Version 2.0
   (the "License"); you may not use this file except in compliance with
   the License.  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
var showControllersOnly = false;
var seriesFilter = "";
var filtersOnlySampleSeries = true;

/*
 * Add header in statistics table to group metrics by category
 * format
 *
 */
function summaryTableHeader(header) {
    var newRow = header.insertRow(-1);
    newRow.className = "tablesorter-no-sort";
    var cell = document.createElement('th');
    cell.setAttribute("data-sorter", false);
    cell.colSpan = 1;
    cell.innerHTML = "Requests";
    newRow.appendChild(cell);

    cell = document.createElement('th');
    cell.setAttribute("data-sorter", false);
    cell.colSpan = 3;
    cell.innerHTML = "Executions";
    newRow.appendChild(cell);

    cell = document.createElement('th');
    cell.setAttribute("data-sorter", false);
    cell.colSpan = 7;
    cell.innerHTML = "Response Times (ms)";
    newRow.appendChild(cell);

    cell = document.createElement('th');
    cell.setAttribute("data-sorter", false);
    cell.colSpan = 1;
    cell.innerHTML = "Throughput";
    newRow.appendChild(cell);

    cell = document.createElement('th');
    cell.setAttribute("data-sorter", false);
    cell.colSpan = 2;
    cell.innerHTML = "Network (KB/sec)";
    newRow.appendChild(cell);
}

/*
 * Populates the table identified by id parameter with the specified data and
 * format
 *
 */
function createTable(table, info, formatter, defaultSorts, seriesIndex, headerCreator) {
    var tableRef = table[0];

    // Create header and populate it with data.titles array
    var header = tableRef.createTHead();

    // Call callback is available
    if(headerCreator) {
        headerCreator(header);
    }

    var newRow = header.insertRow(-1);
    for (var index = 0; index < info.titles.length; index++) {
        var cell = document.createElement('th');
        cell.innerHTML = info.titles[index];
        newRow.appendChild(cell);
    }

    var tBody;

    // Create overall body if defined
    if(info.overall){
        tBody = document.createElement('tbody');
        tBody.className = "tablesorter-no-sort";
        tableRef.appendChild(tBody);
        var newRow = tBody.insertRow(-1);
        var data = info.overall.data;
        for(var index=0;index < data.length; index++){
            var cell = newRow.insertCell(-1);
            cell.innerHTML = formatter ? formatter(index, data[index]): data[index];
        }
    }

    // Create regular body
    tBody = document.createElement('tbody');
    tableRef.appendChild(tBody);

    var regexp;
    if(seriesFilter) {
        regexp = new RegExp(seriesFilter, 'i');
    }
    // Populate body with data.items array
    for(var index=0; index < info.items.length; index++){
        var item = info.items[index];
        if((!regexp || filtersOnlySampleSeries && !info.supportsControllersDiscrimination || regexp.test(item.data[seriesIndex]))
                &&
                (!showControllersOnly || !info.supportsControllersDiscrimination || item.isController)){
            if(item.data.length > 0) {
                var newRow = tBody.insertRow(-1);
                for(var col=0; col < item.data.length; col++){
                    var cell = newRow.insertCell(-1);
                    cell.innerHTML = formatter ? formatter(col, item.data[col]) : item.data[col];
                }
            }
        }
    }

    // Add support of columns sort
    table.tablesorter({sortList : defaultSorts});
}

$(document).ready(function() {

    // Customize table sorter default options
    $.extend( $.tablesorter.defaults, {
        theme: 'blue',
        cssInfoBlock: "tablesorter-no-sort",
        widthFixed: true,
        widgets: ['zebra']
    });

    var data = {"OkPercent": 84.06525868812157, "KoPercent": 15.934741311878422};
    var dataset = [
        {
            "label" : "FAIL",
            "data" : data.KoPercent,
            "color" : "#FF6347"
        },
        {
            "label" : "PASS",
            "data" : data.OkPercent,
            "color" : "#9ACD32"
        }];
    $.plot($("#flot-requests-summary"), dataset, {
        series : {
            pie : {
                show : true,
                radius : 1,
                label : {
                    show : true,
                    radius : 3 / 4,
                    formatter : function(label, series) {
                        return '<div style="font-size:8pt;text-align:center;padding:2px;color:white;">'
                            + label
                            + '<br/>'
                            + Math.round10(series.percent, -2)
                            + '%</div>';
                    },
                    background : {
                        opacity : 0.5,
                        color : '#000'
                    }
                }
            }
        },
        legend : {
            show : true
        }
    });

    // Creates APDEX table
    createTable($("#apdexTable"), {"supportsControllersDiscrimination": true, "overall": {"data": [0.8109285953737848, 500, 1500, "Total"], "isController": false}, "titles": ["Apdex", "T (Toleration threshold)", "F (Frustration threshold)", "Label"], "items": [{"data": [0.45116453794139744, 500, 1500, "POST  - Update Pet with Form  "], "isController": false}, {"data": [0.9392265193370166, 500, 1500, "POST - Upload Image  "], "isController": false}, {"data": [0.9916666666666667, 500, 1500, "POST - Update Pet with Form"], "isController": false}, {"data": [0.9487096774193549, 500, 1500, "POST - Create Pet"], "isController": false}, {"data": [1.0, 500, 1500, "Debug Sampler"], "isController": false}, {"data": [0.5445383615084526, 500, 1500, "GET - Get Pet by ID"], "isController": false}, {"data": [0.9494715984147952, 500, 1500, "GET - Find Pets by Status"], "isController": false}, {"data": [0.9308152580403889, 500, 1500, "POST - Upload Image"], "isController": false}]}, function(index, item){
        switch(index){
            case 0:
                item = item.toFixed(3);
                break;
            case 1:
            case 2:
                item = formatDuration(item);
                break;
        }
        return item;
    }, [[0, 0]], 3);

    // Create statistics table
    createTable($("#statisticsTable"), {"supportsControllersDiscrimination": true, "overall": {"data": ["Total", 8949, 1426, 15.934741311878422, 202.56777293552406, 0, 2527, 150.0, 374.0, 553.0, 967.0, 1.0021221608078523, 3.2283931459250668, 11.545440305674694], "isController": false}, "titles": ["Label", "#Samples", "FAIL", "Error %", "Average", "Min", "Max", "Median", "90th pct", "95th pct", "99th pct", "Transactions/s", "Received", "Sent"], "items": [{"data": ["POST  - Update Pet with Form  ", 1331, 718, 53.944402704733285, 184.19684447783584, 129, 1037, 141.0, 265.79999999999995, 387.5999999999988, 718.7200000000003, 0.14917417356835383, 0.05673765808567731, 0.03357979661793793], "isController": false}, {"data": ["POST - Upload Image  ", 181, 0, 0.0, 332.3701657458564, 188, 1657, 286.0, 539.4000000000001, 615.5000000000001, 1016.5800000000054, 0.02068025706130805, 0.009007221337249405, 1.3886674790618112], "isController": false}, {"data": ["POST - Update Pet with Form", 180, 0, 0.0, 217.24444444444453, 130, 555, 206.0, 316.40000000000003, 365.1999999999998, 533.9399999999999, 0.020567019002554424, 0.007993821838883457, 0.005503284381542883], "isController": false}, {"data": ["POST - Create Pet", 1550, 0, 0.0, 238.18322580645207, 129, 2161, 148.0, 465.900000000001, 759.7999999999993, 1154.98, 0.17368511404276643, 0.07023030684640948, 0.04494354011694723], "isController": false}, {"data": ["Debug Sampler", 1318, 0, 0.0, 0.22989377845220016, 0, 36, 0.0, 1.0, 1.0, 1.0, 0.1477200894838539, 0.07257562406273957, 0.0], "isController": false}, {"data": ["GET - Get Pet by ID", 1538, 698, 45.38361508452536, 180.43888166449938, 128, 879, 146.0, 272.0, 319.04999999999995, 429.099999999999, 0.17234636464591116, 0.06857755033118966, 0.023028402376934275], "isController": false}, {"data": ["GET - Find Pets by Status", 1514, 10, 0.6605019815059445, 245.03368560105727, 130, 2527, 156.0, 451.0, 700.0, 1150.9999999999982, 0.16958947138379296, 2.8794456389784595, 0.026136715367259217], "isController": false}, {"data": ["POST - Upload Image", 1337, 0, 0.0, 336.8489154824231, 186, 1322, 273.0, 571.2000000000003, 703.0999999999999, 1038.8599999999997, 0.14983845576509905, 0.06526167116331462, 10.059416560874311], "isController": false}]}, function(index, item){
        switch(index){
            // Errors pct
            case 3:
                item = item.toFixed(2) + '%';
                break;
            // Mean
            case 4:
            // Mean
            case 7:
            // Median
            case 8:
            // Percentile 1
            case 9:
            // Percentile 2
            case 10:
            // Percentile 3
            case 11:
            // Throughput
            case 12:
            // Kbytes/s
            case 13:
            // Sent Kbytes/s
                item = item.toFixed(2);
                break;
        }
        return item;
    }, [[0, 0]], 0, summaryTableHeader);

    // Create error table
    createTable($("#errorsTable"), {"supportsControllersDiscrimination": false, "titles": ["Type of error", "Number of errors", "% in errors", "% in all samples"], "items": [{"data": ["500/Server Error", 10, 0.7012622720897616, 0.11174432897530451], "isController": false}, {"data": ["404/Not Found", 1416, 99.29873772791024, 15.822996982903117], "isController": false}]}, function(index, item){
        switch(index){
            case 2:
            case 3:
                item = item.toFixed(2) + '%';
                break;
        }
        return item;
    }, [[1, 1]]);

        // Create top5 errors by sampler
    createTable($("#top5ErrorsBySamplerTable"), {"supportsControllersDiscrimination": false, "overall": {"data": ["Total", 8949, 1426, "404/Not Found", 1416, "500/Server Error", 10, "", "", "", "", "", ""], "isController": false}, "titles": ["Sample", "#Samples", "#Errors", "Error", "#Errors", "Error", "#Errors", "Error", "#Errors", "Error", "#Errors", "Error", "#Errors"], "items": [{"data": ["POST  - Update Pet with Form  ", 1331, 718, "404/Not Found", 718, "", "", "", "", "", "", "", ""], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": ["GET - Get Pet by ID", 1538, 698, "404/Not Found", 698, "", "", "", "", "", "", "", ""], "isController": false}, {"data": ["GET - Find Pets by Status", 1514, 10, "500/Server Error", 10, "", "", "", "", "", "", "", ""], "isController": false}, {"data": [], "isController": false}]}, function(index, item){
        return item;
    }, [[0, 0]], 0);

});
