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

    var data = {"OkPercent": 100.0, "KoPercent": 0.0};
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
    createTable($("#apdexTable"), {"supportsControllersDiscrimination": true, "overall": {"data": [0.8831848120883379, 500, 1500, "Total"], "isController": false}, "titles": ["Apdex", "T (Toleration threshold)", "F (Frustration threshold)", "Label"], "items": [{"data": [1.0, 500, 1500, "GET - Get Pet by ID statusSold"], "isController": false}, {"data": [0.16666666666666666, 500, 1500, "POST - Create Pet"], "isController": false}, {"data": [1.0, 500, 1500, "POST - Update Pet with Form (change name and status)"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusSold 1"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusSold 0"], "isController": false}, {"data": [0.8283333333333334, 500, 1500, "POST - Upload Image  "], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusSold 5"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusSold 4"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusSold 3"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusAvailable"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusSold 2"], "isController": false}, {"data": [1.0, 500, 1500, "POST - Update Pet with Form (change name and status) 1"], "isController": false}, {"data": [1.0, 500, 1500, "POST - Update Pet with Form (change name and status) 0"], "isController": false}, {"data": [1.0, 500, 1500, "POST - Update Pet with Form (change name and status) 3"], "isController": false}, {"data": [1.0, 500, 1500, "POST - Update Pet with Form (change name and status) 2"], "isController": false}, {"data": [1.0, 500, 1500, "POST - Update Pet with Form (change name and status) 5"], "isController": false}, {"data": [1.0, 500, 1500, "POST - Update Pet with Form (change name and status) 4"], "isController": false}, {"data": [1.0, 500, 1500, "POST - Update Pet with Form (change name and status) 7"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Find Pets by Status= available"], "isController": false}, {"data": [1.0, 500, 1500, "POST - Update Pet with Form (change name and status) 6"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusAvailable 7"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusAvailable 5"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusAvailable 6"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusAvailable 3"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusAvailable 4"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusAvailable 1"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusAvailable 2"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusSold 6"], "isController": false}, {"data": [1.0, 500, 1500, "GET - Get Pet by ID statusAvailable 0"], "isController": false}]}, function(index, item){
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
    createTable($("#statisticsTable"), {"supportsControllersDiscrimination": true, "overall": {"data": ["Total", 2581, 0, 0.0, 387.8574196048036, 128, 2910, 142.0, 782.0000000000009, 2493.0, 2905.0, 13.373957831356515, 17.650855975726344, 63.74311623807562], "isController": false}, "titles": ["Label", "#Samples", "FAIL", "Error %", "Average", "Min", "Max", "Median", "90th pct", "95th pct", "99th pct", "Transactions/s", "Received", "Sent"], "items": [{"data": ["GET - Get Pet by ID statusSold", 300, 0, 0.0, 138.79000000000005, 128, 219, 138.0, 146.0, 148.0, 162.0, 1.6129032258064515, 0.6360677083333334, 0.21263860887096775], "isController": false}, {"data": ["POST - Create Pet", 300, 0, 0.0, 1927.706666666667, 526, 2910, 2383.0, 2903.0, 2906.0, 2908.0, 1.6339424307616897, 0.6813412284523842, 0.5345417131886386], "isController": false}, {"data": ["POST - Update Pet with Form (change name and status)", 300, 0, 0.0, 139.42666666666665, 129, 172, 139.0, 147.0, 149.0, 160.0, 1.6155784848027919, 0.613730498621373, 0.4086277612928936], "isController": false}, {"data": ["GET - Get Pet by ID statusSold 1", 49, 0, 0.0, 137.55102040816317, 129, 154, 137.0, 146.0, 146.5, 154.0, 0.2649235776577512, 0.10456814922496337, 0.03492644822636368], "isController": false}, {"data": ["GET - Get Pet by ID statusSold 0", 128, 0, 0.0, 138.90625000000003, 130, 170, 139.0, 145.0, 148.55, 164.19999999999987, 0.6906412712115898, 0.2726534467990396, 0.0910513394663717], "isController": false}, {"data": ["POST - Upload Image  ", 300, 0, 0.0, 477.99333333333357, 136, 838, 402.0, 805.9000000000001, 812.0, 831.0, 1.6197567125417762, 0.7038981807432524, 64.06772624626781], "isController": false}, {"data": ["GET - Get Pet by ID statusSold 5", 4, 0, 0.0, 135.5, 133, 138, 135.5, 138.0, 138.0, 138.0, 0.021723900091783478, 0.008459380040623694, 0.002863990734756611], "isController": false}, {"data": ["GET - Get Pet by ID statusSold 4", 4, 0, 0.0, 138.5, 135, 145, 137.0, 145.0, 145.0, 145.0, 0.02171859220085354, 0.008377777264977683, 0.0028632909639797147], "isController": false}, {"data": ["GET - Get Pet by ID statusSold 3", 10, 0, 0.0, 137.9, 132, 146, 137.0, 146.0, 146.0, 146.0, 0.05429589088697768, 0.021421425701502912, 0.007158149677482409], "isController": false}, {"data": ["GET - Get Pet by ID statusAvailable", 300, 0, 0.0, 142.17000000000007, 129, 180, 140.0, 155.0, 162.0, 174.0, 1.629301355578728, 0.6541178215697776, 0.21480047168274247], "isController": false}, {"data": ["GET - Get Pet by ID statusSold 2", 19, 0, 0.0, 136.10526315789474, 131, 144, 134.0, 144.0, 144.0, 144.0, 0.1028227552169019, 0.040376534223742315, 0.013555734330353278], "isController": false}, {"data": ["POST - Update Pet with Form (change name and status) 1", 69, 0, 0.0, 137.63768115942037, 130, 149, 138.0, 143.0, 147.0, 149.0, 0.3732594748401476, 0.1413194096955501, 0.09440840232773264], "isController": false}, {"data": ["POST - Update Pet with Form (change name and status) 0", 150, 0, 0.0, 137.96666666666664, 129, 155, 137.0, 145.9, 150.0, 154.49, 0.8086994495452414, 0.3068319434934738, 0.2045440990548999], "isController": false}, {"data": ["POST - Update Pet with Form (change name and status) 3", 12, 0, 0.0, 137.91666666666666, 130, 149, 136.0, 149.0, 149.0, 149.0, 0.06515896071457661, 0.024689137458257543, 0.016480635571362638], "isController": false}, {"data": ["POST - Update Pet with Form (change name and status) 2", 27, 0, 0.0, 137.03703703703698, 130, 150, 137.0, 143.0, 147.2, 150.0, 0.1463628823730302, 0.05550545506659511, 0.037019518100209786], "isController": false}, {"data": ["POST - Update Pet with Form (change name and status) 5", 3, 0, 0.0, 134.0, 133, 136, 133.0, 136.0, 136.0, 136.0, 0.016336577051465663, 0.00617407745988009, 0.004132005328446882], "isController": false}, {"data": ["POST - Update Pet with Form (change name and status) 4", 5, 0, 0.0, 133.8, 132, 137, 134.0, 137.0, 137.0, 137.0, 0.027205406258331653, 0.010366747580079112, 0.00688105490323037], "isController": false}, {"data": ["POST - Update Pet with Form (change name and status) 7", 1, 0, 0.0, 130.0, 130, 130, 130.0, 130.0, 130.0, 130.0, 7.6923076923076925, 2.8771033653846154, 1.9456129807692306], "isController": false}, {"data": ["GET - Find Pets by Status= available", 300, 0, 0.0, 146.53000000000011, 131, 190, 143.0, 161.0, 170.95, 183.99, 1.6249417729198037, 13.498738300419234, 0.2538971520187193], "isController": false}, {"data": ["POST - Update Pet with Form (change name and status) 6", 1, 0, 0.0, 131.0, 131, 131, 131.0, 131.0, 131.0, 131.0, 7.633587786259541, 2.944596851145038, 1.9307609732824427], "isController": false}, {"data": ["GET - Get Pet by ID statusAvailable 7", 2, 0, 0.0, 137.5, 134, 141, 137.5, 141.0, 141.0, 141.0, 12.738853503184714, 5.312002388535032, 1.679438694267516], "isController": false}, {"data": ["GET - Get Pet by ID statusAvailable 5", 6, 0, 0.0, 142.83333333333334, 134, 153, 143.0, 153.0, 153.0, 153.0, 4.288777698355968, 1.7213746426018584, 0.5654150285918513], "isController": false}, {"data": ["GET - Get Pet by ID statusAvailable 6", 3, 0, 0.0, 147.66666666666666, 135, 155, 153.0, 155.0, 155.0, 155.0, 19.35483870967742, 7.667590725806452, 2.551663306451613], "isController": false}, {"data": ["GET - Get Pet by ID statusAvailable 3", 13, 0, 0.0, 140.46153846153845, 130, 150, 140.0, 148.0, 150.0, 150.0, 0.07077795865478323, 0.028322880540416935, 0.009331078533589585], "isController": false}, {"data": ["GET - Get Pet by ID statusAvailable 4", 7, 0, 0.0, 141.2857142857143, 134, 151, 141.0, 151.0, 151.0, 151.0, 5.235602094240838, 2.0429658283470458, 0.6902405104712042], "isController": false}, {"data": ["GET - Get Pet by ID statusAvailable 1", 83, 0, 0.0, 141.12048192771087, 128, 156, 141.0, 151.0, 153.0, 156.0, 0.45118994553104513, 0.18253678319235914, 0.05948304945965927], "isController": false}, {"data": ["GET - Get Pet by ID statusAvailable 2", 33, 0, 0.0, 141.39393939393943, 129, 159, 140.0, 150.4, 159.0, 159.0, 0.17955372737214959, 0.0726620863462993, 0.023671633979726752], "isController": false}, {"data": ["GET - Get Pet by ID statusSold 6", 3, 0, 0.0, 137.33333333333334, 137, 138, 137.0, 138.0, 138.0, 138.0, 0.016288678825260482, 0.006521834295270311, 0.0021474332435646145], "isController": false}, {"data": ["GET - Get Pet by ID statusAvailable 0", 149, 0, 0.0, 145.19463087248323, 129, 177, 142.0, 160.0, 166.0, 177.0, 0.8100291393032661, 0.3236750638101814, 0.1067909509823642], "isController": false}]}, function(index, item){
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
    createTable($("#errorsTable"), {"supportsControllersDiscrimination": false, "titles": ["Type of error", "Number of errors", "% in errors", "% in all samples"], "items": []}, function(index, item){
        switch(index){
            case 2:
            case 3:
                item = item.toFixed(2) + '%';
                break;
        }
        return item;
    }, [[1, 1]]);

        // Create top5 errors by sampler
    createTable($("#top5ErrorsBySamplerTable"), {"supportsControllersDiscrimination": false, "overall": {"data": ["Total", 2581, 0, "", "", "", "", "", "", "", "", "", ""], "isController": false}, "titles": ["Sample", "#Samples", "#Errors", "Error", "#Errors", "Error", "#Errors", "Error", "#Errors", "Error", "#Errors", "Error", "#Errors"], "items": [{"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}, {"data": [], "isController": false}]}, function(index, item){
        return item;
    }, [[0, 0]], 0);

});
