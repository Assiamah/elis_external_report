$(document).ready(function() {


              function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }



    var plan_submitted;
    var user_unit = $('#user_unit').val();
    var unit_name = $('#unit_name').val();

    var regionalcode = $('#region_id').val();

  
  
    flatpickr("#datefrom", {
        dateFormat: "Y-m-d", // Internal value format (YYYY-MM-DD)
        altInput: true, // Enables an alternative input field for display
        altFormat: "j F Y", // Display format (e.g., "1 February 2025")
        allowInput: true, // Allows manual input
        onClose: function(selectedDates, dateStr, instance) {
            let formattedDate = instance.formatDate(selectedDates[0], "j F Y"); // Format in "1 February 2025"
            
            console.log("Selected date (YYYY-MM-DD):", dateStr); 
            console.log("Selected date (j F Y):", formattedDate); 
    
            $('#start_date').val(dateStr);

            $('#startdate').val(formattedDate);

        }
    });
    
    
    
    
    flatpickr("#dateto", {
        dateFormat: "Y-m-d", // Internal value format (YYYY-MM-DD)
        altInput: true, // Enables an alternative input field for display
        altFormat: "j F Y", // Display format (e.g., "1 February 2025")
        allowInput: true, // Allows manual input
        onClose: function(selectedDates, dateStr, instance) {
            let formattedDate = instance.formatDate(selectedDates[0], "j F Y"); // Format in "1 February 2025"
            console.log("Selected date:", dateStr); // Logs in YYYY-MM-DD format
            $('#end_date').val(dateStr);


            $('#enddate').val(formattedDate);


    
        }
    });
  



    $(document).ready(function() {
      

        $.ajax({
            type : "POST",
            url : "app_modal_fills_serv",
            data : {
                request_type : 'get_divisions_get_list',
            },
            cache : false,
            success : function(
                    jobdetails) {
                var json_p = JSON.parse(jobdetails);
                var options = $("#ur_division");
                options.empty();
                options.append(new Option("-- Select --",0));
                $(json_p)
                        .each(
                                function() {
                                    $(
                                            '#ur_division')
                                            .append(
                                                    '<option value="'
                                                            
                                                            + this.division_name
                                                            + '">'
                                                            + this.division_name
                                                            + '</option>');
    
    
                                });
    
                                $("#ur_division").val($(event.relatedTarget).data('division'));
            }
        });
    






       
            // On change of Division dropdown
            $('#ur_division').change(function () {
                var selected_division = $(this).val(); // Get selected division
                var office_id = $("#ur_district").val(); // Get selected district
        
                // Clear the selected department & unit dropdown
                $("#ur_department").val("");
                $("#ur_units").empty().append('<option value="">Select</option>'); // Clear previous units
        
                // First AJAX to get units
                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                        request_type: 'get_lc_list_of_units',
                        office_id: office_id
                    },
                    cache: false,
                    success: function (jobdetails) {
                        var json_p = JSON.parse(jobdetails);
                        var unitSelect = $("#ur_units");
        
                        // Populate the units dropdown
                        json_p.data.forEach(function (unit) {
                            if (unit.unit_division.includes(selected_division)) {
                                unitSelect.append(`
                                    <option data-name="${unit.unit_name}" data-id="${unit.unit_id}" value="${unit.unit_id}">
                                        ${unit.unit_name}
                                    </option>
                                `);
                            }
                        });
                    }
                });
            });



              $('#sel_change_region_compliance_1').change(function () {
                 
                                            
                                            
        
                // Clear the selected department & unit dropdown
                $("#ur_division").val("");
                 $("#ur_units").val("");
                  $("#by_batched").val("");
        
            });

        
            // On change of Units dropdown
            // $('#ur_units').change(function () {
            //     var unitid = $(this).val(); // Get selected unit ID
            //     var unit_name = $("#ur_units option:selected").data("name"); // Get selected unit name
        
            //     // Clear previous users
            //     $("#by_batched").empty();
        
            //     // Append selected unit as the first option
            //     $("#by_batched").append(`
            //         <option data-name="${unit_name}" data-id="${unitid}" value="${unitid}">
            //             ${unit_name} (Unit)
            //         </option>
            //     `);
        
            //     // Second AJAX to get users in the selected unit
            //     $.ajax({
            //         type: "POST",
            //         url: "reports_api",
            //         data: {
            //             request_type: 'general_user_in_unit',
            //             unitid: unitid
            //         },
            //         cache: false,
            //         success: function (response) {
            //             var json_result = JSON.parse(response);
            //             var userSelect = $("#by_batched");
        
            //             // Populate the user dropdown
            //             json_result.apps_at_division.forEach(user => {
            //                 userSelect.append(`
            //                     <option value="${user.userid}" data-name="${user.fullname}">
            //                         ${user.fullname}
            //                     </option>
            //                 `);
            //             });
        
            //             // Auto-select the first user if available
            //             if (json_result.apps_at_division.length > 0) {
            //                 let firstUser = json_result.apps_at_division[0];
            //                 $('#by_batched').val(firstUser.userid);
            //             }
        
            //             // Update input field with unit name
            //             $('#select-user').val(unit_name);
            //         },
            //         error: function (xhr, status, error) {
            //             console.error("Error fetching data:", error);
            //         }
            //     });
            // });



             $('#ur_units').change(function () {
                var unitid = $(this).val(); // Get selected unit ID
                var unit_name = $("#ur_units option:selected").data("name"); // Get selected unit name
				 var division_name =$("#ur_division").val();
				var regional_cod = $("#sel_change_region_compliance_1").val();
			 let region_code = Math.trunc(regional_cod);

             if (regional_cod === "0" || regional_cod === 0) {
        Swal.fire(
            'Oops!',
            'Please select a region first.',
            'warning'
        );
        // Reset the units dropdown if needed
        $(this).val(""); 
        return; // Stop further execution
    }


             console.log(region_code,division_name,unitid)
        
                // Clear previous users
                $("#by_batched").empty();
        
                // Append selected unit as the first option
                $("#by_batched").append(`
                    <option data-name="${unit_name}" data-id="${unitid}" value="${unitid}">
                        ${unit_name} (Unit)
                    </option>
                `);
        

                // obj.put( "region_code" , region_code );
				// obj.put( "unit_id" , unit_id );
				// obj.put( "division" , division_name );


                // Second AJAX to get users in the selected unit
             	$.ajax({
						type : "POST",
						url : "Case_Management_Serv",
						data : {
						request_type : 'get_lc_list_of_users_rpt',
						region_code : region_code,
						division_name : division_name,
						unit_id : unit_name
						},
                    cache: false,
                    success: function (response) {
                        var json_result = JSON.parse(response);
						console.log(json_result);

                        var userSelect = $("#by_batched");


                        // Check if data exists and is an array
                            if (Array.isArray(json_result.data) && json_result.data.length > 0) {
                                json_result.data.forEach(user => {
                                    userSelect.append(`
                                        <option value="${user.userid}" data-name="${user.fullname}">
                                            ${user.fullname}
                                        </option>
                                    `);
                                });

                                // Auto-select the first user
                                const firstUser = json_result.data[0];
                                userSelect.val(firstUser.userid);

                                // Update any input field if needed
                                $('#select-user').val(firstUser.unit_id || '');
                            } else {
                                // Show alert if no users found
                                Swal.fire(
                                    'Sorry!',
                                    'No users found in this unit',
                                    'info'
                                );

                            }
        
                        // Update input field with unit name
                        $('#select-user').val(unit_name);
                    },
                    error: function (xhr, status, error) {
                        console.error("Error fetching data:", error);
                    }
                });
            });									


    });




  
      $('#reportrange').on('apply.daterangepicker', function(ev, picker) {
          
  
          $('#start_date').val(picker.startDate.format('YYYY-MM-DD'));
          $('#end_date').val(picker.endDate.format('YYYY-MM-DD'));
  
      });
  
  
      $('#by_batched').change(function(){
          // console.log("selection made " + $(this).val() );
          const selectedOption = this.options[this.selectedIndex];
  
  
           surveyorName = selectedOption.getAttribute('data-name') || 'STAMPING UNIT';
  
  
                        $('#select-user').val(surveyorName);
      })
      
  
  
      $('#btn_generate_details_reports_1').click(function(e){
          e.preventDefault();

      
          
          var user_id = $('#by_batched').val();
          var type_of_report_name = $('#type_of_report_name_1').val();
          var start_date = $('#start_date').val();
          var end_date = $('#end_date').val();
          var user_division = $('#user_division').val();
        //   var region_code = $('#sel_change_region_compliance_1').val();
          var regional_cod = $("#sel_change_region_compliance_1").val();
			 let region_code = Math.trunc(regional_cod);



          var startdate = $('#startdate').val().toUpperCase();
          var enddate = $('#enddate').val().toUpperCase();




          var type_of_report_upper = type_of_report_name.toUpperCase();


          var name = $('#select-user').val();

          
  
        //   regional_code = Math.trunc(region_cod);
  
  
          var surveyyy_by = $('#survey_select').val();
  
  
  
  
      // document.getElementById('reportheading').innerHTML = start_date;
  
      
           
           console.log(user_id,type_of_report_name,start_date,end_date,region_code);
  
  
           if(type_of_report_name !='' && start_date !='' && end_date !=''){
  
  
  
  
          //  if ($('#search_bill_number').parsley().isValid()) {
  
          //     // alert('Are you sure you want to save instrument?') 
          
          e.preventDefault();
          // fields validation
            $.ajax({
              type : "POST",
              url : "reports_api",
              data : {
                  request_type : 'report_on_smd_cartogis',
                  application_status : type_of_report_name,
                  date_from : start_date,
                  date_to : end_date,
                  userid:user_id,
                  regionid :region_code
  
              },
              cache: false,
            beforeSend:function(){  
              $(this).prop('disabled', false);
           $('#btn_generate_details_reports_1').text("Loading...Please Wait").prop("disabled",true); 
            },
            success:function(response){ 
  
  
              json_result = JSON.parse(response);
           
            console.log(json_result);
  
  
            if (json_result.data == null){

                Swal.fire(
																	'Sorry!',
																	'We couldn\'t find any results matching your search criteria. Please review your filters or try again later',
																	'info'
																);

                                                                
  
            //   alert('We couldn\'t find any results matching your search criteria. Please review your filters or try again later.');
  
              $('#btn_generate_details_reports_1')
          .prop("disabled", false)
          .html(`<i class="fas fa-chart-line fa-sm text-white-50"></i>Generate Report`);
  
            }else if (json_result.data != null && type_of_report_name == 'Received'){
  
  
              document.getElementById('reportheading2').innerHTML ='REPORT ON ' + ' ' + type_of_report_upper+ ' ' + "APPLICATIONS" + ' ' + 'BETWEEN '+' '+startdate+ ' ' + 'TO'+ ' ' + enddate + ' ' + 'BY' + ' ' + name;
  
  
              // document.getElementById('reportheading2').innerHTML ='Report On' + ' ' + type_of_report_name+ ' ' + business_process_sub_name + ' ' + 'From '+' '+start_date+ ' ' + 'to'+ ' ' + end_date + ' ' + 'for' + ' ' + surveyyy_by;
  
              // document.getElementById('reportheading2').innerHTML ='Report On' + ' ' + type_of_report_name+ ' ' + 'Plan Approval Applications From '+' '+start_date+ ' ' + 'to'+ ' ' + end_date + ' ' + 'for' + ' ' + surveyyy_by;
  
              Swal.fire(
																	'Successful!',
																	'Your Report has been Generated.',
																	'success'
																);

                                                                
  
              $("#other_reporting_modal").modal("show");  
  
              $('#btn_generate_details_reports_1')
          .prop("disabled", false)
          .html(`<i class="fas fa-chart-line fa-sm text-white-50"></i>Generate Report`);
  
  
  
  
              let dataSet1 = [];
              let num1 = 0;
       
            $('#other_reporting_table').DataTable().clear().destroy();


          


      
      
      
              for(let i=0; i<json_result.data.length; i++) {
                  let html = [];
                  num1 = +num1 + 1;
                  let ar_name = json_result.data[i].ar_name;
                  let job_number = json_result.data[i].job_number;
                  let business_process_sub_name = json_result.data[i].business_process_sub_name;

                  let receiver_name = json_result.data[i].receiver_name;
                  let date_created = json_result.data[i].date_created;
                  let job_purpose = json_result.data[i].job_purpose;
                  let action = `

                  <td class="text-end">
					<div class="dropdown">
						<a href="javascript:void(0);"
						class="btn btn-icon btn-sm btn-primary border action-btn""
						data-bs-toggle="dropdown"
						data-bs-display="static"
						aria-expanded="false">
							<i class="ri-more-2-line"></i>
						</a>

						<ul class="dropdown-menu dropdown-menu-end table-dropdown" data-popper-placement="bottom-end">

							<!-- Cabinet -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								data-bs-toggle="modal"
								data-bs-target="#cabinetModal"
								data-target-id="${escapeHtml(json_result.data[i].job_number || '')}">
									<i class="ri-hard-drive-2-line me-2"></i>
									Track
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
						
					

							<!-- Application Details (Form Submit) -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								onclick="viewApplicationDetails('${json_result.data[i].job_number}','${json_result.data[i].transaction_number}','${json_result.data[i].case_number}','${json_result.data[i].business_process_sub_name}')">
									<i class="ri-information-line me-2"></i>
									Application Details
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
							

						</ul>
					</div>
				</td>

                `;
                
  
        
                  
                  html.push(ar_name);
                  html.push(job_number);
                  html.push(business_process_sub_name);
                  html.push(receiver_name);
                  html.push(date_created);
                  html.push(job_purpose);
                  html.push(action);

                  
      
               
                  // html.push(action);
                  // html.push(payment_status);
                  // html.push(buttons);
      
                  dataSet1.push(html);
      
                //console.log(dataSet)
                }
      
              // let dataTable_Obj = $('#recievedtoday').DataTable({
              //     data: dataSet1
              //   })
      
                $('#other_reporting_table').DataTable().clear().destroy();


                document.getElementById('reportheading2').innerHTML ='REPORT ON ' + ' ' + type_of_report_upper+ ' ' + "APPLICATIONS" + ' ' + 'BETWEEN '+' '+startdate+ ' ' + 'TO'+ ' ' + enddate + ' ' + 'BY' + ' ' + name;


  
  
                $('#other_reporting_table').DataTable({ data: dataSet1,
                  dom : 'Bfrtip',
                                lengthMenu : [
                                    [ 10, 25, 50, -1 ],
                                    [ '10 rows', '25 rows',
                                        '50 rows', 'Show all' ] ],
  
                                        buttons: [
                                          'pageLength', // Default page length button
                                          'copy',       // Default copy button
                                          {
                                              extend: 'csv',
                                              title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                              filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                          },
                                          {
                                              extend: 'excel',
                                              title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                              filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                          },
                                          {
                                              extend: 'pdf',
                                              title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                              filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                          },
                                          {
                                              extend: 'print',
                                              title: `<h3>REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}</h3>`,
                                              message: 'This report is generated using LC ELIS'
                                          }
                                      ],
                                      pageLength: 10, // Default rows displayed
  
  
                              //   buttons : [ 'pageLength', 'copy',
                              //       'csv', 'excel', 'pdf', 'print' ] 
                }).draw();
              
  
            } else {

                document.getElementById('reportheading').innerHTML ='REPORT ON ' + ' ' + type_of_report_upper+ ' ' + "APPLICATIONS" + ' ' + 'BETWEEN '+' '+startdate+ ' ' + 'TO'+ ' ' + enddate + ' ' + 'BY' + ' ' + name;

  
  
                // document.getElementById('reportheading2').innerHTML ='Report On' + ' ' + type_of_report_name+ ' ' + business_process_sub_name + ' ' + 'From '+' '+start_date+ ' ' + 'to'+ ' ' + end_date + ' ' + 'for' + ' ' + surveyyy_by;
    
                // document.getElementById('reportheading2').innerHTML ='Report On' + ' ' + type_of_report_name+ ' ' + 'Plan Approval Applications From '+' '+start_date+ ' ' + 'to'+ ' ' + end_date + ' ' + 'for' + ' ' + surveyyy_by;


                    Swal.fire(
																	'Successful!',
																	'Your Report has been Generated.',
																	'success'
																);
    
    
                $("#reporting_modal").modal("show");  
    
                $('#btn_generate_details_reports_1')
            .prop("disabled", false)
            .html(`<i class="fas fa-chart-line fa-sm text-white-50"></i>Generate Report`);
    
    
    
    
                let dataSet1 = [];
                let num1 = 0;
         
              $('#reporting_table').DataTable().clear().destroy();
  
  
            
  
  
        
        
        
                for(let i=0; i<json_result.data.length; i++) {
                    let html = [];
                    num1 = +num1 + 1;
                    let ar_name = json_result.data[i].ar_name;
                    let job_number = json_result.data[i].job_number;
                    let business_process_sub_name = json_result.data[i].business_process_sub_name;
  
                    let officers_general_comments = json_result.data[i].officers_general_comments;
                    let date_created = json_result.data[i].date_created;
                    let job_purpose = json_result.data[i].job_purpose;
                    let action = ` <td class="text-end">
					<div class="dropdown">
						<a href="javascript:void(0);"
						class="btn btn-icon btn-sm btn-primary border action-btn""
						data-bs-toggle="dropdown"
						data-bs-display="static"
						aria-expanded="false">
							<i class="ri-more-2-line"></i>
						</a>

						<ul class="dropdown-menu dropdown-menu-end table-dropdown" data-popper-placement="bottom-end">

							<!-- Cabinet -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								data-bs-toggle="modal"
								data-bs-target="#cabinetModal"
								data-target-id="${escapeHtml(json_result.data[i].job_number || '')}">
									<i class="ri-hard-drive-2-line me-2"></i>
									Track
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
						
					

							<!-- Application Details (Form Submit) -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								onclick="viewApplicationDetails('${json_result.data[i].job_number}','${json_result.data[i].transaction_number}','${json_result.data[i].case_number}','${json_result.data[i].business_process_sub_name}')">
									<i class="ri-information-line me-2"></i>
									Application Details
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
							

						</ul>
					</div>
				</td>`;
                  
    
          
                    
                    html.push(ar_name);
                    html.push(job_number);
                    html.push(business_process_sub_name);
                    html.push(officers_general_comments);
                    html.push(date_created);
                    html.push(job_purpose);
                    html.push(action);

                    
        
                 
                    
                    // html.push(payment_status);
                    // html.push(buttons);
        
                    dataSet1.push(html);
        
                  //console.log(dataSet)
                  }
        
                // let dataTable_Obj = $('#recievedtoday').DataTable({
                //     data: dataSet1
                //   })
        
                  $('#reporting_table').DataTable().clear().destroy();
    
    
                  $('#reporting_table').DataTable({ data: dataSet1,
                    dom : 'Bfrtip',
                                  lengthMenu : [
                                      [ 10, 25, 50, -1 ],
                                      [ '10 rows', '25 rows',
                                          '50 rows', 'Show all' ] ],
    
                                          buttons: [
                                            'pageLength', // Default page length button
                                            'copy',       // Default copy button
                                            {
                                                extend: 'csv',
                                                title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                                filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                            },
                                            {
                                                extend: 'excel',
                                                title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                                filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                            },
                                            {
                                                extend: 'pdf',
                                                title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                                filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                            },
                                            {
                                                extend: 'print',
                                                title: `<h3>REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}</h3>`,
                                                message: 'This report is generated using LC ELIS'
                                            }
                                        ],
                                        pageLength: 10, // Default rows displayed
    
    
                                //   buttons : [ 'pageLength', 'copy',
                                //       'csv', 'excel', 'pdf', 'print' ] 
                  }).draw();
                





            }
  
             
            } 
  
            });
  
  
  
  
  
           }else {
  
  
            alert('Sorry!. All Fields Required');
  
           }
  
  
  
  
      
  
        });


  

        const $cabinetModal = $('#cabinetModal');
    // ==================== CABINET MODAL FUNCTIONALITY ====================
    $cabinetModal.on('show.bs.modal', handleCabinetModalShow);


        function clearTableRows($table) {
        $table.find("tbody tr").remove();
    }

       function handleAjaxError(xhr, status, error) {
        console.error('AJAX Error:', error);
        showNotification(
            `Error loading data. Please try again.`,
            'error'
        );
    }

          function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    function updateRefreshTime() {
		const now = new Date();
		const timeString = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
		$('#lastRefreshTime').text(timeString);
	}

    function handleCabinetModalShow(event) {
        const jobNumber = $(event.relatedTarget).data('target-id');
        
        if (!jobNumber) {
            console.error('No job number provided for cabinet modal');
            return;
        }

        resetCabinetModal();
        loadCabinetDetails(jobNumber);
    }

    function resetCabinetModal() {
        const fields = [
            '#enq_applicant_name',
            '#enq_applicant_type',
            '#enq_cabinet_name',
            '#enq_job_purpose',
            '#enq_job_status',
            '#enq_current_application_status'
        ];
        
        fields.forEach(selector => $(selector).val(''));
        clearTableRows($('#cabinet-tracking'));
    }

    function loadCabinetDetails(jobNumber) {
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_cabinet_details_by_job_number',
                job_number: jobNumber
            },
            cache: false,
            success: function(response) {
                populateCabinetData(response);
				updateRefreshTime();
            },
            error: handleAjaxError
        });
    }

    function populateCabinetData(response) {
        try {
            const data = JSON.parse(response);
            // console.log(data);
            // Populate cabinet tracking table
            if (data.cabinet_tracking && Array.isArray(data.cabinet_tracking)) {
                const table = $('#cabinet-tracking');
				table.empty();
                data.cabinet_tracking.forEach(tracking => {
                    table.append(createCabinetTrackingRow(tracking));
                });

				// Update last update date
				if (data.cabinet_tracking && data.cabinet_tracking.length > 0) {
					const lastUpdate = data.cabinet_tracking[data.cabinet_tracking.length - 1].created_date;
					$('#lastUpdateDate').text(lastUpdate);
				}

				const trackingCount = Array.isArray(data.cabinet_tracking) ? data.cabinet_tracking.length : 0;
				$('#trackingEntriesCount').text(trackingCount);
				$('#historyCount').text(trackingCount + ' entries');
            }

            // Populate cabinet data fields
            if (data.cabinet_data) {
                const cabinet = data.cabinet_data;
                $('#enq_applicant_name').val(cabinet.ar_name || '');
                $('#enq_applicant_type').val(cabinet.business_process_sub_name || '');
                $('#enq_cabinet_name').val(cabinet.file_number || '');
                $('#enq_job_purpose').val(cabinet.job_purpose || '');
                $('#enq_job_status').val(cabinet.job_status || '');
                $('#enq_current_application_status').val(cabinet.current_application_status || '');
            }
        } catch (error) {
            console.error('Error parsing cabinet data:', error);
        }
    }

    function createCabinetTrackingRow(tracking) {
        return `
            <tr>
                <td class="small">${escapeHtml(tracking.officers_general_comments || '')}</td>
                <td class="small">${escapeHtml(tracking.division || '')}</td>
                <td class="small">${escapeHtml(tracking.created_by || '')}</td>
                <td class="small">${formatDate(tracking.created_date)}</td>
            </tr>
        `;
    }




    window.viewApplicationDetails = function(job_number, transaction_number, case_number, business_process_sub_name) {
     
      // Create a form dynamically
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = 'front_office_view_application';
      form.target = '_blank'
      form.style.display = 'none'; // Hide the form
      
      // Add the case number as an input field
      const caseNumberInput = document.createElement('input');
      caseNumberInput.type = 'hidden';
      caseNumberInput.name = 'search_text';
      caseNumberInput.value = case_number;
      form.appendChild(caseNumberInput);

      // Add the case number as an input field
      const jobNumberInput = document.createElement('input');
      jobNumberInput.type = 'hidden';
      jobNumberInput.name = 'search_text';
      jobNumberInput.value = job_number;
      form.appendChild(jobNumberInput);

      // Add the case number as an input field
      const transactionNumberInput = document.createElement('input');
      transactionNumberInput.type = 'hidden';
      transactionNumberInput.name = 'search_text';
      transactionNumberInput.value = transaction_number;
      form.appendChild(transactionNumberInput);

      // Add the case number as an input field
      const businessProcessSubNameInput = document.createElement('input');
      businessProcessSubNameInput.type = 'hidden';
      businessProcessSubNameInput.name = 'search_text';
      businessProcessSubNameInput.value = business_process_sub_name;
      form.appendChild(businessProcessSubNameInput);
      
      // Add the form to the body and submit it
      document.body.appendChild(form);
      form.submit();
};





     
  
    });
  



    
  
    