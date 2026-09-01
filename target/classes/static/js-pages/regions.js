// Regions initialization and management
console.log('regions.js loaded from static assets');

$(document).ready(function() {
    // Add your region loading or handling logic here
    console.log('Regions initialized');
     $.ajax({
        type: "GET",
        url: "ComplianceReport",
        data: {
            request_type: 'select_lc_office_regions_districts_all'
        },
        cache: false,
        success: function(jobdetails) {
            var regions = JSON.parse(jobdetails);
            console.log(regions);

            const select = document.getElementById('sel_change_region_compliance');
            select.innerHTML = ''; // clear previous options if any

            // Add default "Select Region" option
            const defaultOption = document.createElement('option');
            defaultOption.value = '';
            defaultOption.textContent = 'Select Region';
            defaultOption.disabled = true;
            defaultOption.selected = true;
            select.appendChild(defaultOption);

            // Sort and add region options
            const sortedRegions = regions.data.sort((a, b) => 
                a.ord_region_name.localeCompare(b.ord_region_name)
            );

            sortedRegions.forEach(region => {
                const option = document.createElement('option');
                option.value = region.ord_region_code;
                option.textContent = region.ord_region_name;
                
                // Auto-select region code 11
                if (region.ord_region_code == "11") {
                    option.selected = true;
                }
                
                select.appendChild(option);
            });

            // Trigger change if code 11 was selected to update dashboard
            if (select.value == "11") {
                $(select).trigger('change');
            }
        }
    });
});