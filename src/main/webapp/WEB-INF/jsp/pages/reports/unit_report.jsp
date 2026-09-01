<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<jsp:useBean id="now" class="java.util.Date" />

<style>
    .report-card {
        transition: all 0.3s ease;
        border: none;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .report-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1) !important;
    }

    .report-card .card-header {
        background: linear-gradient(135deg, #6c757d 0%, #212529 100%);
        border-bottom: none;
        padding: 1.25rem 1.5rem;
    }

    .report-card .card-header h4 {
        color: white;
        margin: 0;
    }

    .section-icon {
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        margin-right: 15px;
    }

    .section-icon.service {
        background: rgba(102, 126, 234, 0.1);
        color: #667eea;
    }

    .section-icon.division {
        background: rgba(40, 167, 69, 0.1);
        color: #28a745;
    }

    .section-icon.count {
        background: rgba(23, 162, 184, 0.1);
        color: #17a2b8;
    }

    .form-control-sm {
        border-radius: 8px;
        border: 1px solid #dee2e6;
        padding: 0.5rem 0.75rem;
        font-size: 0.875rem;
    }

    .form-label {
        font-weight: 600;
        color: #495057;
        margin-bottom: 0.5rem;
        font-size: 0.875rem;
    }

    .action-buttons .btn {
        border-radius: 8px;
        padding: 0.5rem 1.25rem;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .action-buttons .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }

    .data-table {
        border-radius: 8px;
        overflow: hidden;
    }

    .data-table thead th {
        background-color: #f8f9fa;
        border-bottom: 2px solid #dee2e6;
        font-weight: 600;
        color: #495057;
        padding: 1rem;
    }

    .data-table tbody td {
        padding: 0.75rem 1rem;
        vertical-align: middle;
    }

    .accordion-button {
        border-radius: 8px !important;
        padding: 1rem 1.25rem;
        font-weight: 600;
    }

    .accordion-button:not(.collapsed) {
        background-color: rgba(102, 126, 234, 0.1);
        color: #667eea;
        box-shadow: none;
    }

    .accordion-button:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
    }

    .stats-icon {
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
    }

    .stats-icon.bg-primary {
        background-color: rgba(102, 126, 234, 0.1);
        color: #667eea;
    }

    .stats-icon.bg-success {
        background-color: rgba(40, 167, 69, 0.1);
        color: #28a745;
    }

    .stats-icon.bg-danger {
        background-color: rgba(220, 53, 69, 0.1);
        color: #dc3545;
    }

    .stats-icon.bg-info {
        background-color: rgba(23, 162, 184, 0.1);
        color: #17a2b8;
    }

    @media (max-width: 768px) {
        .report-card .card-header {
            padding: 1rem;
        }
        
        .section-icon {
            width: 40px;
            height: 40px;
            margin-right: 10px;
        }
        
        .stats-icon {
            width: 40px;
            height: 40px;
        }
        
        .action-buttons {
            flex-direction: column;
            gap: 10px;
        }
        
        .action-buttons .btn {
            width: 100%;
        }
    }

    /* Allow multiple modals */
.modal.fade:not(.show) {
    z-index: 1050 !important;
}
.modal.fade.show {
    z-index: 1060 !important;
}
.modal-backdrop {
    z-index: 1040 !important;
}
.modal-backdrop.show ~ .modal-backdrop {
    z-index: 1041 !important;
}
.modal.show ~ .modal-backdrop.show {
    z-index: 1042 !important;
}

</style>

<!-- Begin Page Content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-4">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div class="d-flex align-center gap-2">
                    <div>
                        <h1 class="page-title fw-medium fs-20 mb-1"><i class="ri-bar-chart-line me-2 text-primary"></i>Unit Applications Report</h1>
                        <p class="text-muted fs-14 mb-0">Detailed reporting for ELIS system - Report Unit | User</p>
                    </div>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS Report</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${fullname}</li>
                </ol>
            </div>
        </div>

        <div class="row">
            <!-- Main Report Card -->
            <div class="col-lg-12 mb-4">
                <div class="card report-card h-100">
                    <div class="card-header d-flex align-items-center">
                        <div class="section-icon service">
                            <i class="ri-database-line fs-4"></i>
                        </div>
                        <h4 class="mb-0">Unit Applications Report</h4>
                    </div>
                    
                     <div class="card-body">
                        <div class="accordion" id="unitReportAccordion">
                            <div class="accordion-item border-0">
                                <h2 class="accordion-header" id="unitReportHeading">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#unitReportCollapse">
                                        <i class="ri-filter-line me-2"></i>Filter Options
                                    </button>
                                </h2>
                                <div id="unitReportCollapse" class="accordion-collapse collapse show" data-bs-parent="#unitReportAccordion">
                                    <div class="accordion-body p-0 pt-3">
                                        <!-- Hidden Inputs -->
                                        <input type="hidden" value="${userid}" id="user_id">
                                        <input type="hidden" value="${unit_id}" id="user_unit">
                                        <input type="hidden" value="${division}" id="user_division">
                                        <input type="hidden" value="${unit_name}" id="unit_name">
                                        <input type="hidden" value="${region_id}" id="region_id">
                                        <input type="hidden" id="select-user">
                                        <input type="hidden" id="startdate">
                                        <input type="hidden" id="enddate">
                                        <input type="hidden" id="start_date" name="start_date">
                                        <input type="hidden" id="end_date" name="end_date">
                                        <input type="hidden" id="survey_select" name="survey_select">
                                        
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label">Status Type</label>
                                                <select name="type_of_report_name" id="type_of_report_name" class="form-select form-select-sm" required>
                                                    <option value="Received">Received</option>
                                                    <option value="Batched">Batched</option>
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="form-label">Division</label>
                                                <select id="ur_division" class="form-select form-select-sm">
                                                    <!-- Options will be loaded dynamically -->
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="form-label">Unit</label>
                                                <select id="ur_units" class="form-select form-select-sm">
                                                    <!-- Options will be loaded dynamically -->
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="form-label">User</label>
                                                <select name="by_batched" id="by_batched" class="form-select form-select-sm" required>
                                                    <!-- Options will be loaded dynamically -->
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="form-label">Date From</label>
                                                <input type="text" id="datefrom" class="form-control form-control-sm" placeholder="Select Start Date" required>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="form-label">Date To</label>
                                                <input type="text" id="dateto" class="form-control form-control-sm" placeholder="Select End Date" required>
                                            </div>
                                        </div>
                                        
                                        <div class="action-buttons mt-4 d-flex gap-2">
                                            <button type="button" class="btn btn-primary" id="btn_generate_details_reports_1">
                                                <i class="ri-eye-line me-1"></i>Generate Report
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Reporting Modal (Bootstrap 5) -->
<div class="modal fade effect-scale modal-blur" id="reporting_modal" tabindex="-1" aria-labelledby="reportingModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header bg-gradient-primary">
                <div class="d-flex align-items-center w-100">
                    <div class="modal-icon-container me-3">
                        <div class="avatar avatar-lg bg-dark">
                            <i class="ri-file-list-line text-primary fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title text-dark" id="reportingModalLabel">
                            <span id="reportheading"></span>
                        </h5>
                        <p class="text-dark-50 mb-0">Application Report Details</p>
                    </div>
                    <button type="button" class="btn-close btn-close-dark" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover data-table" id="reporting_table" width="100%" cellspacing="0">
                        <thead class="table-light">
                            <tr>
                                <th>Applicant Name</th>
                                <th>Job Number</th>
                                <th>Application Type</th>
                                <th>Application Destination</th>
                                <th>Date Batched</th>
                                <th>Job Purpose</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Data will be populated here -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Other Reporting Modal (Bootstrap 5) -->
<div class="modal fade effect-scale modal-blur" id="other_reporting_modal" tabindex="-1" aria-labelledby="otherReportingModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header bg-gradient-primary">
                <div class="d-flex align-items-center w-100">
                    <div class="modal-icon-container me-3">
                        <div class="avatar avatar-lg bg-dark">
                            <i class="ri-file-list-line text-primary fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title text-dark" id="otherReportingModalLabel">
                            <span id="reportheading2"></span>
                        </h5>
                        <p class="text-dark-50 mb-0">Application Report Details</p>
                    </div>
                    <button type="button" class="btn-close btn-close-dark" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover data-table" id="other_reporting_table" width="100%" cellspacing="0">
                        <thead class="table-light">
                            <tr>
                                <th>Applicant Name</th>
                                <th>Job Number</th>
                                <th>Application Type</th>
                                <th>Received By</th>
                                <th>Date Received</th>
                                <th>Job Purpose</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Data will be populated here -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Cabinet Modal (Bootstrap 5) -->
<div class="modal fade effect-scale modal-blur" id="cabinetModal" tabindex="-1" aria-labelledby="cabinetModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header rounded-top">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-grow-1">
                        <h5 class="modal-title fw-semibold mb-0" id="cabinetModalLabel">
                            <i class="fas fa-history me-2"></i>Application Tracking History
                        </h5>
                        <small class="opacity-75">View complete application tracking and cabinet details</small>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <div class="row g-4">
                    <!-- Left Column: Tracking History -->
                    <div class="col-lg-8">
                        <div class="card border-0 shadow">
                            <div class="card-header bg-light py-3 d-flex justify-content-between align-items-center">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-stream me-2 text-primary"></i>Tracking History
                                </h6>
                                <span class="badge bg-primary" id="historyCount">0 entries</span>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-comment me-2"></i>Comments
                                                </th>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-building me-2"></i>Division/Unit
                                                </th>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-user-tie me-2"></i>Officer
                                                </th>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-calendar me-2"></i>Date
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="cabinet-tracking">
                                            <!-- Tracking data will be populated here -->
                                            <tr id="noTrackingData" class="d-none">
                                                <td colspan="4" class="text-center py-5">
                                                    <div class="d-flex flex-column align-items-center">
                                                        <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                                        <h6 class="fw-semibold mb-2">No tracking history found</h6>
                                                        <p class="text-muted small">No tracking entries available for this application</p>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer bg-light py-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="text-muted small">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Shows all tracking activities for this application
                                    </div>
                                    <button type="button" class="btn btn-sm btn-outline-primary" id="btnExportHistory">
                                        <i class="fas fa-download me-2"></i>Export
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Application Details -->
                    <div class="col-lg-4">
                        <div class="card border-0 shadow">
                            <div class="card-header bg-light py-3">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-info-circle me-2 text-success"></i>Application Details
                                </h6>
                            </div>
                            <div class="card-body">
                                <form id="cabinetDetailsForm">
                                    <!-- Applicant Information Section -->
                                    <div class="mb-4">
                                        <h6 class="fw-semibold mb-3 text-primary">
                                            <i class="fas fa-user-circle me-2"></i>Applicant Information
                                        </h6>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="enq_applicant_name" class="form-label fw-medium">
                                                    Applicant Name
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-user"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_applicant_name" rows="2"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="enq_applicant_type" class="form-label fw-medium">
                                                    Application Type
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-file-alt"></i>
                                                    </span>
                                                    <input type="text" readonly class="form-control bg-light" 
                                                           id="enq_applicant_type">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Cabinet Information Section -->
                                    <div class="mb-4">
                                        <h6 class="fw-semibold mb-3 text-success">
                                            <i class="fas fa-archive me-2"></i>Cabinet Information
                                        </h6>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="enq_cabinet_name" class="form-label fw-medium">
                                                    Cabinet/File Reference
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-hashtag"></i>
                                                    </span>
                                                    <input type="text" readonly class="form-control bg-light" 
                                                           id="enq_cabinet_name">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Status Information Section -->
                                    <div class="mb-4">
                                        <h6 class="fw-semibold mb-3 text-warning">
                                            <i class="fas fa-tasks me-2"></i>Status Information
                                        </h6>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="enq_job_purpose" class="form-label fw-medium">
                                                    Job Purpose
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-bullseye"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_job_purpose" rows="3"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="enq_job_status" class="form-label fw-medium">
                                                    Job Status
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-spinner"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_job_status" rows="3"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="enq_current_application_status" class="form-label fw-medium">
                                                    Current Application Status
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-flag"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_current_application_status" rows="3"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Quick Stats -->
                                    <div class="card border-dashed border-2 mt-4">
                                        <div class="card-body p-3">
                                            <h6 class="fw-semibold mb-3">
                                                <i class="fas fa-chart-bar me-2"></i>Quick Stats
                                            </h6>
                                            <div class="row g-2">
                                                <div class="col-6">
                                                    <div class="d-flex flex-column align-items-center p-2 bg-light rounded">
                                                        <span class="text-muted small">Tracking Entries</span>
                                                        <small class="fw-bold" id="trackingEntriesCount">0</small>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="d-flex flex-column align-items-center p-2 bg-light rounded">
                                                        <span class="text-muted small">Last Update</span>
                                                        <small class="fw-bold" id="lastUpdateDate">-</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="card-footer bg-light py-3">
                                <div class="text-muted small">
                                    <i class="fas fa-clock me-1"></i>
                                    Last refreshed: <span id="lastRefreshTime">-</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light rounded-bottom p-3">
                <!-- <div class="d-flex justify-content-between w-100">
                    <div>
                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Close
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-outline-primary me-2" id="btnRefreshCabinet">
                            <i class="fas fa-sync-alt me-2"></i>Refresh
                        </button>
                        <button type="button" class="btn btn-primary" id="btnPrintHistory">
                            <i class="fas fa-print me-2"></i>Print History
                        </button>
                    </div>
                </div> -->
                <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // Initialize Select2 for better dropdown styling
    $(document).ready(function() {
        $('#by_batched').select2({
            placeholder: "Select User",
            allowClear: true,
            width: '100%',
            dropdownParent: $('#unitReportCollapse')
        });
        
        // Initialize date pickers
        initializeDatePickers();
    });
    
    function initializeDatePickers() {
        // You can use flatpickr or any other date picker here
        // For example:
        // flatpickr("#datefrom", { dateFormat: "Y-m-d" });
        // flatpickr("#dateto", { dateFormat: "Y-m-d" });
    }
    
    // Update the existing apps_report.js to use Bootstrap 5
    // Make sure to change data-dismiss to data-bs-dismiss
    // and data-toggle to data-bs-toggle in your JavaScript file
</script>

<!-- Include your JavaScript file -->
<!-- <script type="text/javascript" src="../js_includes/apps_report.js"></script> -->