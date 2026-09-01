<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
 <jsp:useBean id="now" class="java.util.Date"/>    


<!-- Division Modal-->
<!-- <div class="modal fade" data-position="0" id="divisionModal" tabindex="-1" role="dialog"
	aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row"></div>
			</div>
		</div>
	</div>
</div> -->


<div class="modal fade effect-scale modal-blur" id="user_divisionModal" tabindex="-1" aria-labelledby="userDivisionModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="icon-wrapper bg-white bg-opacity-25 rounded-circle px-2 py-1">
                            <i class="ri-calendar-event-line fs-4 text-primary"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title mb-0" id="userDivisionModalLabel">
                            Applications Received
                        </h5>
                        <small class="opacity-75">Today (<fmt:formatDate value="${now}" type="date" />)</small>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Loading State -->
                <div id="loadingState" class="text-center py-5">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mt-3">Loading division data...</p>
                </div>
                
                <!-- Error State -->
                <div id="errorState" class="text-center py-5 d-none">
                    <div class="mb-4">
                        <i class="ri-error-warning-line display-1 text-danger opacity-50"></i>
                    </div>
                    <h5 class="text-danger mb-3">Unable to Load Data</h5>
                    <p class="text-muted">Please try again later.</p>
                    <button class="btn btn-primary mt-2" id="retryButton">
                        <i class="ri-refresh-line me-2"></i>Retry
                    </button>
                </div>
                
                <!-- Data Content -->
                <div id="dataContent" class="d-none">
                    <div class="row">
                        <!-- Main Division Card -->
                        <div class="col-xl-12 mb-4">
                            <div class="card border-start-primary border-start-4 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <div class="text-muted small text-uppercase fw-semibold mb-1">
                                                Your Division
                                            </div>
                                            <div class="d-flex align-items-center">
                                                <h2 class="mb-0 me-3 fw-bold" id="div_count">0</h2>
                                                <div>
                                                    <div class="h5 mb-0 fw-bold" id="user_division">-</div>
                                                    <div class="text-muted small">Applications received today</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <div class="bg-primary bg-opacity-10 rounded-circle p-3">
                                                <i class="ri-building-2-line text-primary fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- All Divisions Section -->
                        <div class="col-12">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-bar-chart-2-line text-primary me-2"></i>
                                        All Divisions Today
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3" id="allDivisionsGrid">
                                        <!-- All division cards will be loaded here -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div class="text-muted small">
                        <i class="ri-time-line me-1"></i>
                        Last updated: <span id="lastUpdated">Just now</span>
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">
                            <i class="ri-close-line me-2"></i>Close
                        </button>
                        <button class="btn btn-primary ms-2" type="button" id="refreshButton">
                            <i class="ri-refresh-line me-2"></i>Refresh
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>







<div class="modal fade effect-scale modal-blur" id="user_divisionModal_this_month" tabindex="-1" aria-labelledby="userDivisionMonthModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="icon-wrapper bg-white bg-opacity-25 rounded-circle px-2 py-1">
                            <i class="ri-calendar-2-line fs-4 text-primary"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title mb-0" id="userDivisionMonthModalLabel">
                            Applications Received
                        </h5>
                        <small class="opacity-75">This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)</small>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Loading State -->
                <div id="loadingStateMonth" class="text-center py-5">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mt-3">Loading monthly division data...</p>
                </div>
                
                <!-- Error State -->
                <div id="errorStateMonth" class="text-center py-5 d-none">
                    <div class="mb-4">
                        <i class="ri-error-warning-line display-1 text-danger opacity-50"></i>
                    </div>
                    <h5 class="text-danger mb-3">Unable to Load Monthly Data</h5>
                    <p class="text-muted">Please try again later.</p>
                    <button class="btn btn-primary mt-2" id="retryButtonMonth">
                        <i class="ri-refresh-line me-2"></i>Retry
                    </button>
                </div>
                
                <!-- Data Content -->
                <div id="dataContentMonth" class="d-none">
                    <div class="row">
                        <!-- Main Division Card -->
                        <div class="col-xl-12 mb-4">
                            <div class="card border-start-primary border-start-4 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="row align-items-center mb-2">
                                        <div class="col">
                                            <div class="text-muted small text-uppercase fw-semibold mb-1">
                                                Your Division - This Month
                                            </div>
                                            <div class="d-flex align-items-center">
                                                <h2 class="mb-0 me-3 fw-bold" id="div_count_month">0</h2>
                                                <div>
                                                    <div class="h5 mb-0 fw-bold" id="user_division_month">-</div>
                                                    <div class="text-muted small">Applications received this month</div>
                                                </div>
                                            </div>
                                            <div class="mt-3">
                                                <div class="text-muted small mb-1">
                                                    <i class="ri-calendar-line me-1"></i>
                                                    Month of <span class="fw-medium"><fmt:formatDate value="${now}" pattern="MMMM yyyy" /></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <div class="bg-primary bg-opacity-10 rounded-circle py-x px-3">
                                                <i class="ri-calendar-2-line text-primary fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="position-absolute bottom-0 start-0 m-3 mt-3" id="user_division_this_month" style="cursor: pointer;">
                                        <span class="btn btn-sm btn-warning px-3">
                                            View Details <i class="ri-arrow-right-line ms-1"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Monthly Stats -->
                        <div class="col-12 mb-4">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-info bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-arrow-up-down-line text-info fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Monthly Trend</div>
                                                    <h4 class="mb-0 fw-bold" id="monthlyTrend">--</h4>
                                                    <div class="text-success small">
                                                        <i class="ri-arrow-up-line me-1"></i>
                                                        <span>Compared to last month</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-success bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-file-chart-line text-success fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Daily Average</div>
                                                    <h4 class="mb-0 fw-bold" id="dailyAverage">--</h4>
                                                    <div class="text-muted small">Applications per day</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- All Divisions Section -->
                        <div class="col-12">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-bar-chart-horizontal-line text-primary me-2"></i>
                                        All Divisions This Month
                                    </h6>
                                    <small class="text-muted">Comparison across all divisions</small>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3" id="allDivisionsGridMonth">
                                        <!-- All division cards will be loaded here -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div class="text-muted small">
                        <i class="ri-calendar-event-line me-1"></i>
                        Month: <span class="fw-medium"><fmt:formatDate value="${now}" pattern="MMMM yyyy" /></span>
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">
                            <i class="ri-close-line me-2"></i>Close
                        </button>
                        <button class="btn btn-primary ms-2" type="button" id="refreshButtonMonth">
                            <i class="ri-refresh-line me-2"></i>Refresh
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="modal fade effect-scale modal-blur" id="user_completed_divison_today" tabindex="-1" aria-labelledby="userCompletedDivisionTodayLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="icon-wrapper bg-white bg-opacity-25 rounded-circle px-2 py-1">
                            <i class="ri-checkbox-circle-line fs-4 text-primary"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title mb-0" id="userCompletedDivisionTodayLabel">
                            Applications Completed
                        </h5>
                        <small class="opacity-75">Today (<fmt:formatDate value="${now}" type="date" />)</small>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Loading State -->
                <div id="loadingStateCompletedToday" class="text-center py-5">
                    <div class="spinner-border text-success" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mt-3">Loading completed applications data...</p>
                </div>
                
                <!-- Error State -->
                <div id="errorStateCompletedToday" class="text-center py-5 d-none">
                    <div class="mb-4">
                        <i class="ri-error-warning-line display-1 text-danger opacity-50"></i>
                    </div>
                    <h5 class="text-danger mb-3">Unable to Load Completed Data</h5>
                    <p class="text-muted">Please try again later.</p>
                    <button class="btn btn-success mt-2" id="retryButtonCompletedToday">
                        <i class="ri-refresh-line me-2"></i>Retry
                    </button>
                </div>
                
                <!-- Data Content -->
                <div id="dataContentCompletedToday" class="d-none">
                    <div class="row">
                        <!-- Main Division Card -->
                        <div class="col-xl-12 mb-4">
                            <div class="card border-start-success border-start-4 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <div class="text-muted small text-uppercase fw-semibold mb-1">
                                                <i class="ri-checkbox-circle-line text-success me-1"></i>
                                                Your Division - Completed Today
                                            </div>
                                            <div class="d-flex align-items-center">
                                                <h2 class="mb-0 me-3 fw-bold" id="div_count_completed_today">0</h2>
                                                <div>
                                                    <div class="h5 mb-0 fw-bold" id="user_division_completed_today">-</div>
                                                    <div class="text-muted small">Applications completed today</div>
                                                </div>
                                            </div>
                                            <!-- Completion Rate (if available) -->
                                            <div class="mt-3" id="completionRateSection">
                                                <div class="d-flex align-items-center">
                                                    <div class="progress flex-grow-1 me-3" style="height: 8px;">
                                                        <div class="progress-bar bg-success" role="progressbar" 
                                                             style="width: 0%" 
                                                             id="completionProgress"
                                                             aria-valuenow="0" 
                                                             aria-valuemin="0" 
                                                             aria-valuemax="100"></div>
                                                    </div>
                                                    <div class="text-end">
                                                        <div class="text-success fw-bold" id="completionPercentage">0%</div>
                                                        <div class="text-muted x-small">Completion Rate</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <div class="bg-success bg-opacity-10 rounded-circle p-3">
                                                <i class="ri-checkbox-circle-line text-success fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Performance Stats -->
                        <div class="col-12 mb-4">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-success bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-time-line text-success fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Processing Time</div>
                                                    <h4 class="mb-0 fw-bold" id="avgProcessingTime">--</h4>
                                                    <div class="text-muted small">Average days</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-info bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-timer-flash-line text-info fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Fastest Completion</div>
                                                    <h4 class="mb-0 fw-bold" id="fastestCompletion">--</h4>
                                                    <div class="text-muted small">Days taken</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-warning bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-alarm-warning-line text-warning fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">On-Time Rate</div>
                                                    <h4 class="mb-0 fw-bold" id="onTimeRate">--</h4>
                                                    <div class="text-muted small">Completed on time</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- All Divisions Completed Today -->
                        <div class="col-12">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-check-double-line text-success me-2"></i>
                                        All Divisions - Completed Today
                                    </h6>
                                    <small class="text-muted">Completion performance across divisions</small>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3" id="allDivisionsCompletedGrid">
                                        <!-- All division completion cards will be loaded here -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Service Type Breakdown -->
                        <div class="col-12 mt-4">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-file-list-line text-success me-2"></i>
                                        Completed by Service Type
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-sm">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Service Type</th>
                                                    <th class="text-center">Completed</th>
                                                    <th class="text-center">Avg. Days</th>
                                                    <th class="text-center">Status</th>
                                                </tr>
                                            </thead>
                                            <tbody id="serviceTypeCompletedTable">
                                                <!-- Service type data will be loaded here -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div class="text-muted small">
                        <i class="ri-bar-chart-box-line me-1"></i>
                        Performance metrics for completed applications
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">
                            <i class="ri-close-line me-2"></i>Close
                        </button>
                        <button class="btn btn-success ms-2" type="button" id="refreshButtonCompletedToday">
                            <i class="ri-refresh-line me-2"></i>Refresh
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>







<div class="modal fade effect-scale modal-blur" id="user_completed_divison_month" tabindex="-1" aria-labelledby="userCompletedDivisionMonthLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="icon-wrapper bg-white bg-opacity-25 rounded-circle px-2 py-1">
                            <i class="ri-calendar-check-line fs-4 text-primary"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title mb-0" id="userCompletedDivisionMonthLabel">
                            Applications Completed
                        </h5>
                        <small class="opacity-75">This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)</small>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Loading State -->
                <div id="loadingStateCompletedMonth" class="text-center py-5">
                    <div class="spinner-border text-success" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mt-3">Loading monthly completion data...</p>
                </div>
                
                <!-- Error State -->
                <div id="errorStateCompletedMonth" class="text-center py-5 d-none">
                    <div class="mb-4">
                        <i class="ri-error-warning-line display-1 text-danger opacity-50"></i>
                    </div>
                    <h5 class="text-danger mb-3">Unable to Load Monthly Completion Data</h5>
                    <p class="text-muted">Please try again later.</p>
                    <button class="btn btn-success mt-2" id="retryButtonCompletedMonth">
                        <i class="ri-refresh-line me-2"></i>Retry
                    </button>
                </div>
                
                <!-- Data Content -->
                <div id="dataContentCompletedMonth" class="d-none">
                    <div class="row">
                        <!-- Main Division Card -->
                        <div class="col-xl-12 mb-4">
                            <div class="card border-start-success border-start-4 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <div class="text-muted small text-uppercase fw-semibold mb-1">
                                                <i class="ri-calendar-check-line text-success me-1"></i>
                                                Your Division - Completed This Month
                                            </div>
                                            <div class="d-flex align-items-center">
                                                <h2 class="mb-0 me-3 fw-bold" id="div_count_completed_month">0</h2>
                                                <div>
                                                    <div class="h5 mb-0 fw-bold" id="user_division_completed_month">-</div>
                                                    <div class="text-muted small">
                                                        Applications completed in <span class="fw-medium"><fmt:formatDate value="${now}" pattern="MMMM" /></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Monthly Completion Trend -->
                                            <div class="mt-3">
                                                <div class="d-flex align-items-center">
                                                    <div class="progress flex-grow-1 me-3" style="height: 8px;">
                                                        <div class="progress-bar bg-success" role="progressbar" 
                                                             style="width: 0%" 
                                                             id="monthlyCompletionProgress"
                                                             aria-valuenow="0" 
                                                             aria-valuemin="0" 
                                                             aria-valuemax="100"></div>
                                                    </div>
                                                    <div class="text-end">
                                                        <div class="text-success fw-bold" id="monthlyCompletionPercentage">0%</div>
                                                        <div class="text-muted x-small">of monthly target</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <div class="bg-success bg-opacity-10 rounded-circle p-3">
                                                <i class="ri-calendar-check-line text-success fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Monthly Performance Stats -->
                        <div class="col-12 mb-4">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-success bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-bar-chart-2-line text-success fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Monthly Trend</div>
                                                    <h4 class="mb-0 fw-bold" id="monthlyCompletionTrend">--</h4>
                                                    <div class="text-success small">
                                                        <i class="ri-arrow-up-line me-1"></i>
                                                        <span>vs last month</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-info bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-calendar-schedule-line text-info fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Daily Average</div>
                                                    <h4 class="mb-0 fw-bold" id="monthlyDailyAverage">--</h4>
                                                    <div class="text-muted small">Per working day</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-warning bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-speed-line text-warning fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Completion Rate</div>
                                                    <h4 class="mb-0 fw-bold" id="monthlyCompletionRate">--</h4>
                                                    <div class="text-muted small">vs received</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-timer-line text-primary fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Avg. Time</div>
                                                    <h4 class="mb-0 fw-bold" id="monthlyAvgTime">--</h4>
                                                    <div class="text-muted small">Days per app</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Monthly Chart Section -->
                        <div class="col-12 mb-4">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0 fw-bold">
                                            <i class="ri-line-chart-line text-success me-2"></i>
                                            Monthly Completion Trend
                                        </h6>
                                        <div class="btn-group btn-group-sm" role="group">
                                            <button type="button" class="btn btn-outline-success active" data-chart-type="line">
                                                <i class="ri-line-chart-line me-1"></i>Line
                                            </button>
                                            <button type="button" class="btn btn-outline-success" data-chart-type="bar">
                                                <i class="ri-bar-chart-2-line me-1"></i>Bar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="chart-container" style="position: relative; height: 250px; width: 100%">
                                        <canvas id="monthlyCompletionChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- All Divisions Monthly Completion -->
                        <div class="col-12">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-building-2-line text-success me-2"></i>
                                        All Divisions - Monthly Completion
                                    </h6>
                                    <small class="text-muted">Performance comparison for <fmt:formatDate value="${now}" pattern="MMMM" /></small>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-sm align-middle">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Division</th>
                                                    <th class="text-center">Completed</th>
                                                    <th class="text-center">Monthly Target</th>
                                                    <th class="text-center">Achievement</th>
                                                    <th class="text-center">Trend</th>
                                                    <th class="text-center">Status</th>
                                                </tr>
                                            </thead>
                                            <tbody id="monthlyDivisionsTable">
                                                <!-- Monthly division data will be loaded here -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Weekly Breakdown -->
                        <div class="col-12 mt-4">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-calendar-2-line text-success me-2"></i>
                                        Weekly Completion Breakdown
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3" id="weeklyBreakdownGrid">
                                        <!-- Weekly breakdown cards will be loaded here -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div class="text-muted small">
                        <i class="ri-calendar-2-line me-1"></i>
                        Month: <span class="fw-medium"><fmt:formatDate value="${now}" pattern="MMMM yyyy" /></span>
                        <span class="mx-2">•</span>
                        <i class="ri-pie-chart-line me-1"></i>
                        <span id="totalMonthlyCompleted">0</span> total completed
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">
                            <i class="ri-close-line me-2"></i>Close
                        </button>
                        <button class="btn btn-success ms-2" type="button" id="refreshButtonCompletedMonth">
                            <i class="ri-refresh-line me-2"></i>Refresh
                        </button>
                        <button class="btn btn-outline-success ms-2" type="button" id="exportMonthlyData">
                            <i class="ri-download-line me-2"></i>Export
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<!-- Application Type Modal-->
<div class="modal fade effect-fade modal-blur" data-position="0" id="serviceTypeModal" tabindex="-1" aria-labelledby="serviceTypeModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="serviceTypeModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover w-100" 
                                       id="serviceTypeTable"
                                       data-responsive="true"
                                       data-order='[[1, "desc"]]'
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>">
                                    <thead class="table-light">
                                        <tr>
                                            <th data-data="name" data-name="name">Service Name</th>
                                            <th data-data="total" data-name="total">Count</th>
                                            <th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type" id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>





<div class="modal fade effect-fade modal-blur" data-position="0" id="serviceTypeModalMonth" tabindex="-1" aria-labelledby="serviceTypeModalMonth" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="serviceTypeModalLabelMonth"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover w-100" 
                                       id="created_by_services_month"
                                       data-responsive="true"
                                       data-order='[[1, "desc"]]'
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>">
                                    <thead class="table-light">
                                        <tr>
                                            <th data-data="name" data-name="name">Service Name</th>
                                            <th data-data="total" data-name="total">Count</th>
                                            <th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type" id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>







<div class="modal fade effect-fade modal-blur" data-position="0" id="completedTodayserviceTypeModal" tabindex="-1" aria-labelledby="completedTodayserviceTypeModal" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completedTodayserviceTypeModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover w-100" 
                                       id="completed_serviceType_Table"
                                       data-responsive="true"
                                       data-order='[[1, "desc"]]'
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>">
                                    <thead class="table-light">
                                        <tr>
                                            <th data-data="name" data-name="name">Service Name</th>
                                            <th data-data="total" data-name="total">Count</th>
                                            <th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type" id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>






<div class="modal fade effect-fade modal-blur" data-position="0" id="apps_recieved_year_modal" tabindex="-1" aria-labelledby="apps_recieved_year_modal" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="divisionLabelRecievedYear"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="apps_recieved_year_table" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Service Name</th>
										<th >Count</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type" id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>





<div class="modal fade effect-fade modal-blur" data-position="0" id="completedMonthserviceTypeModal" tabindex="-1" aria-labelledby="completedMonthserviceTypeModal" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completedMonthserviceTypeModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="completed_MonthserviceType_Table" class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Service Name</th>
										<th >Count</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type" id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>





<!-- Units Modal-->
<div class="modal fade effect-fade modal-blur" data-position="0" id="unitModal" tabindex="-1" role="dialog"
	aria-labelledby="unitModalLabel" aria-hidden="true" data-bs-backdrop="static">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionLabelCompletedYear"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
                        <div class="col-12 table-responsive">
							<table class="table" id="apps_past_due_unit" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                   }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th>Unit</th>
										<th>Count</th>
										<th >Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type" id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
		</div>
	</div>
</div>


<!-- Officers Modal-->
<div class="modal fade effect-scale modal-blur" id="officerModal" tabindex="-1" aria-labelledby="officerModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="officerModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">

                            <table class="table" id="past_due_officers_table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                   }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
								       	<th>Officer</th>
                                        <th>Count</th>
                                        <th class="text-end">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type" id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>







<div class="modal fade effect-fade modal-blur"
     data-position="0"
     id="apps_recieved_completed_year_modal"
     tabindex="-1"
     aria-labelledby="appsRecievedCompletedYearLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-scrollable modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="appsRecievedCompletedYearLabel"></h5>
                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">

                        <!-- Table -->
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="apps_recieved_completed_year_table"
                                       class="table table-hover"
                                       style="width:100%"
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>"
                                       data-responsive="true"
                                       data-buttons='{
                                           "buttons": [
                                               { "extend": "excel", "exportOptions": { "columns": [":visible"] } },
                                               { "extend": "print", "exportOptions": { "columns": [":visible"] } },
                                               "colvis"
                                           ]
                                       }'
                                       data-order='[[1,"desc"]]'>
                                    <thead class="table-light">
                                        <tr>
                                            <th>Service Name</th>
                                            <th>Count</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Chart -->
                        <div class="col-12">
                            <div class="chart"></div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="row w-100 align-items-center">

                    <!-- Chart Controls -->
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">

                            <div class="col-auto">
                                <label for="chart_type"
                                       class="col-form-label">
                                    Generate Chart:
                                    <span class="text-danger">*</span>
                                </label>
                            </div>

                            <div class="col-auto">
                                <select class="form-select"
                                        name="chart_type"
                                        id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>

                            <div class="col-auto">
                                <button type="submit"
                                        class="btn btn-primary">
                                    Generate
                                </button>
                                <button type="button"
                                        class="btn btn-outline-danger clear-chart ms-2">
                                    Clear
                                </button>
                            </div>

                        </form>
                    </div>

                    <!-- Close Button -->
                    <div class="col-md-6 text-end">
                        <button type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            Close
                        </button>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>




<div class="modal fade effect-fade modal-blur"
     data-position="0"
     id="apps_completed_year_modal"
     tabindex="-1"
     aria-labelledby="appsCompletedYearLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-scrollable modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="appsCompletedYearLabel"></h5>
                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">

                        <!-- Table -->
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="apps_completed_year_table"
                                       class="table table-hover"
                                       style="width:100%"
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>"
                                       data-responsive="true"
                                       data-buttons='{
                                           "buttons": [
                                               { "extend": "excel", "exportOptions": { "columns": [":visible"] } },
                                               { "extend": "print", "exportOptions": { "columns": [":visible"] } },
                                               "colvis"
                                           ]
                                       }'
                                       data-order='[[1,"desc"]]'>
                                    <thead class="table-light">
                                        <tr>
                                            <th>Service Name</th>
                                            <th>Count</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Chart -->
                        <div class="col-12">
                            <div class="chart"></div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="row w-100 align-items-center">

                    <!-- Chart Controls -->
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">

                            <div class="col-auto">
                                <label for="chart_type"
                                       class="col-form-label">
                                    Generate Chart:
                                    <span class="text-danger">*</span>
                                </label>
                            </div>

                            <div class="col-auto">
                                <select class="form-select"
                                        name="chart_type"
                                        id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>

                            <div class="col-auto">
                                <button type="submit"
                                        class="btn btn-primary">
                                    Generate
                                </button>
                                <button type="button"
                                        class="btn btn-outline-danger clear-chart ms-2">
                                    Clear
                                </button>
                            </div>

                        </form>
                    </div>

                    <!-- Close Button -->
                    <div class="col-md-6 text-end">
                        <button type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            Close
                        </button>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>



<!-- Applications Modal-->

<div class="modal fade" id="completedapplicationsModal" tabindex="-1" aria-labelledby="completedApplicationsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completedApplicationsModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-hover" id="completedApplicationsTable" style="width: 100%">
                                <thead class="table-light">
                                    <tr>
                                        <th>Job Number</th>
                                        <th>Applicant Name</th>
                                        <th>Application Type</th>
                                        <th>Submission Date</th>
                                        <th>Completed Date</th>
                                        <th>TAT</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Data will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>






<div class="modal fade effect-fade modal-blur"
     data-position="0"
     id="applicationsModalRecievedMonth"
     tabindex="-1"
     aria-labelledby="applicationsModalRecievedMonthLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-scrollable modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title"
                    id="applicationsModalRecievedMonthLabel"></h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">

                        <!-- Table -->
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="view_applications_month_by_service_type"
                                       class="table table-hover"
                                       style="width:100%"
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>"
                                       data-responsive="true"
                                       data-buttons='{
                                           "buttons": [
                                               { "extend": "excel", "exportOptions": { "columns": [":visible"] } },
                                               { "extend": "print", "exportOptions": { "columns": [":visible"] } },
                                               "colvis"
                                           ]
                                       }'
                                       data-order='[[1,"desc"]]'>
                                    <thead class="table-light">
                                        <tr>
                                            <th>Job Number</th>
                                            <th>Applicant Name</th>
                                            <th>Application Type</th>
                                            <th>Submission Date</th>
                                            <th>Date Received by Officer</th>
                                            <th>Pending Days</th>
                                            <th>Days With Officer</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Chart -->
                        <div class="col-12">
                            <div class="chart"></div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="row w-100 align-items-center">

                    <!-- Chart Controls -->
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">

                            <div class="col-auto">
                                <label for="chart_type"
                                       class="col-form-label">
                                    Generate Chart:
                                    <span class="text-danger">*</span>
                                </label>
                            </div>

                            <div class="col-auto">
                                <select class="form-select"
                                        name="chart_type"
                                        id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>

                            <div class="col-auto">
                                <button type="submit"
                                        class="btn btn-primary">
                                    Generate
                                </button>
                                <button type="button"
                                        class="btn btn-outline-danger clear-chart ms-2">
                                    Clear
                                </button>
                            </div>

                        </form>
                    </div>

                    <!-- Close Button -->
                    <div class="col-md-6 text-end">
                        <button type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            Close
                        </button>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>







<div class="modal fade effect-fade modal-blur"
     data-position="0"
     id="applicationsModalRecievedYear"
     tabindex="-1"
     aria-labelledby="applicationsModalRecievedYearLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-scrollable modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title"
                    id="applicationsModalRecievedYearLabel"></h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">

                        <!-- Table -->
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="view_applications_year_by_service_type"
                                       class="table table-hover"
                                       style="width:100%"
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>"
                                       data-responsive="true"
                                       data-buttons='{
                                           "buttons": [
                                               { "extend": "excel", "exportOptions": { "columns": [":visible"] } },
                                               { "extend": "print", "exportOptions": { "columns": [":visible"] } },
                                               "colvis"
                                           ]
                                       }'
                                       data-order='[[1,"desc"]]'>
                                    <thead class="table-light">
                                        <tr>
                                            <th>Job Number</th>
                                            <th>Applicant Name</th>
                                            <th>Application Type</th>
                                            <th>Submission Date</th>
                                            <th>Date Received by Officer</th>
                                            <th>Pending Days</th>
                                            <th>Days With Officer</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Chart -->
                        <div class="col-12">
                            <div class="chart"></div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="row w-100 align-items-center">

                    <!-- Chart Controls -->
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">

                            <div class="col-auto">
                                <label for="chart_type"
                                       class="col-form-label">
                                    Generate Chart:
                                    <span class="text-danger">*</span>
                                </label>
                            </div>

                            <div class="col-auto">
                                <select class="form-select"
                                        name="chart_type"
                                        id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>

                            <div class="col-auto">
                                <button type="submit"
                                        class="btn btn-primary">
                                    Generate
                                </button>
                                <button type="button"
                                        class="btn btn-outline-danger clear-chart ms-2">
                                    Clear
                                </button>
                            </div>

                        </form>
                    </div>

                    <!-- Close Button -->
                    <div class="col-md-6 text-end">
                        <button type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            Close
                        </button>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>









<div class="modal fade effect-fade modal-blur"
     data-position="0"
     id="applicationsModalCompletedToday"
     tabindex="-1"
     aria-labelledby="applicationsModalCompletedTodayLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-scrollable modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title"
                    id="applicationsModalCompletedTodayLabel"></h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">

                        <!-- Table -->
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="view_applications_completed_today_by_service_type"
                                       class="table table-hover"
                                       style="width:100%"
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>"
                                       data-responsive="true"
                                       data-buttons='{
                                           "buttons": [
                                               { "extend": "excel", "exportOptions": { "columns": [":visible"] } },
                                               { "extend": "print", "exportOptions": { "columns": [":visible"] } },
                                               "colvis"
                                           ]
                                       }'
                                       data-order='[[1,"desc"]]'>
                                    <thead class="table-light">
                                        <tr>
                                            <th>Job Number</th>
                                            <th>Applicant Name</th>
                                            <th>Application Type</th>
                                            <th>Submission Date</th>
                                            <th>Completed Date</th>
                                            <th>TAT</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Chart -->
                        <div class="col-12">
                            <div class="chart"></div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="row w-100 align-items-center">

                    <!-- Chart Controls -->
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">

                            <div class="col-auto">
                                <label for="chart_type"
                                       class="col-form-label">
                                    Generate Chart:
                                    <span class="text-danger">*</span>
                                </label>
                            </div>

                            <div class="col-auto">
                                <select class="form-select"
                                        name="chart_type"
                                        id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>

                            <div class="col-auto">
                                <button type="submit"
                                        class="btn btn-primary">
                                    Generate
                                </button>
                                <button type="button"
                                        class="btn btn-outline-danger clear-chart ms-2">
                                    Clear
                                </button>
                            </div>

                        </form>
                    </div>

                    <!-- Close Button -->
                    <div class="col-md-6 text-end">
                        <button type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            Close
                        </button>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>







<div class="modal fade effect-fade modal-blur"
     data-position="0"
     id="applicationsModalCompletedMonth"
     tabindex="-1"
     aria-labelledby="applicationsModalCompletedMonthLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-scrollable modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title"
                    id="applicationsModalCompletedMonthLabel"></h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">

                        <!-- Table -->
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="view_applications_completed_month_by_service_type"
                                       class="table table-hover"
                                       style="width:100%"
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>"
                                       data-responsive="true"
                                       data-buttons='{
                                           "buttons": [
                                               { "extend": "excel", "exportOptions": { "columns": [":visible"] } },
                                               { "extend": "print", "exportOptions": { "columns": [":visible"] } },
                                               "colvis"
                                           ]
                                       }'
                                       data-order='[[1,"desc"]]'>
                                    <thead class="table-light">
                                        <tr>
                                            <th>Job Number</th>
                                            <th>Applicant Name</th>
                                            <th>Application Type</th>
                                            <th>Submission Date</th>
                                            <th>Completed Date</th>
                                            <th>TAT</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Chart -->
                        <div class="col-12">
                            <div class="chart"></div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="row w-100 align-items-center">

                    <!-- Chart Controls -->
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">

                            <div class="col-auto">
                                <label for="chart_type"
                                       class="col-form-label">
                                    Generate Chart:
                                    <span class="text-danger">*</span>
                                </label>
                            </div>

                            <div class="col-auto">
                                <select class="form-select"
                                        name="chart_type"
                                        id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>

                            <div class="col-auto">
                                <button type="submit"
                                        class="btn btn-primary">
                                    Generate
                                </button>
                                <button type="button"
                                        class="btn btn-outline-danger clear-chart ms-2">
                                    Clear
                                </button>
                            </div>

                        </form>
                    </div>

                    <!-- Close Button -->
                    <div class="col-md-6 text-end">
                        <button type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            Close
                        </button>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>







<div class="modal fade effect-fade modal-blur"
     data-position="0"
     id="applicationsModalRecievedCompletedYear"
     tabindex="-1"
     aria-labelledby="applicationsModalRecievedCompletedYearLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title"
                    id="applicationsModalRecievedCompletedYearLabel"></h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">

                        <!-- Table -->
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="view_applications_created_completed_year_by_service_type"
                                       class="table table-hover"
                                       style="width:100%"
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>"
                                       data-responsive="true"
                                       data-buttons='{
                                           "buttons": [
                                               { "extend": "excel", "exportOptions": { "columns": [":visible"] } },
                                               { "extend": "print", "exportOptions": { "columns": [":visible"] } },
                                               "colvis"
                                           ]
                                       }'
                                       data-order='[[1,"desc"]]'>
                                    <thead class="table-light">
                                        <tr>
                                            <th>Job Number</th>
                                            <th>Applicant Name</th>
                                            <th>Application Type</th>
                                            <th>Submission Date</th>
                                            <th>Completed Date</th>
                                            <th>TAT</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Chart -->
                        <div class="col-12">
                            <div class="chart"></div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="row w-100 align-items-center">

                    <!-- Chart Controls -->
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">

                            <div class="col-auto">
                                <label for="chart_type"
                                       class="col-form-label">
                                    Generate Chart:
                                    <span class="text-danger">*</span>
                                </label>
                            </div>

                            <div class="col-auto">
                                <select class="form-select"
                                        name="chart_type"
                                        id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>

                            <div class="col-auto">
                                <button type="submit"
                                        class="btn btn-primary">
                                    Generate
                                </button>
                                <button type="button"
                                        class="btn btn-outline-danger clear-chart ms-2">
                                    Clear
                                </button>
                            </div>

                        </form>
                    </div>

                    <!-- Close -->
                    <div class="col-md-6 text-end">
                        <button type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            Close
                        </button>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>




<div class="modal fade effect-fade modal-blur"
     data-position="0"
     id="applicationsModalCompletedYear"
     tabindex="-1"
     aria-labelledby="applicationsModalCompletedYearLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title"
                    id="applicationsModalCompletedYearLabel"></h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">

                        <!-- Table -->
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="view_applications_completed_year_by_service_type"
                                       class="table table-hover"
                                       style="width:100%"
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>"
                                       data-responsive="true"
                                       data-buttons='{
                                           "buttons": [
                                               { "extend": "excel", "exportOptions": { "columns": [":visible"] } },
                                               { "extend": "print", "exportOptions": { "columns": [":visible"] } },
                                               "colvis"
                                           ]
                                       }'
                                       data-order='[[1,"desc"]]'>
                                    <thead class="table-light">
                                        <tr>
                                            <th>Job Number</th>
                                            <th>Applicant Name</th>
                                            <th>Application Type</th>
                                            <th>Submission Date</th>
                                            <th>Completed Date</th>
                                            <th>TAT</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Chart -->
                        <div class="col-12">
                            <div class="chart"></div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="row w-100 align-items-center">

                    <!-- Chart Controls -->
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">

                            <div class="col-auto">
                                <label for="chart_type_completed_year"
                                       class="col-form-label">
                                    Generate Chart:
                                </label>
                            </div>

                            <div class="col-auto">
                                <select class="form-select"
                                        name="chart_type"
                                        id="chart_type_completed_year">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>

                            <div class="col-auto">
                                <button type="submit"
                                        class="btn btn-primary">
                                    Generate
                                </button>
                                <button type="button"
                                        class="btn btn-outline-danger clear-chart ms-2">
                                    Clear
                                </button>
                            </div>

                        </form>
                    </div>

                    <!-- Close -->
                    <div class="col-md-6 text-end">
                        <button type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            Close
                        </button>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>




<div class="modal fade" data-position="0" id="new_modal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="due_date" data-data="due_date">Date Received by Officer</th>
										<th data-name="days_due" data-data="days_due">Pending Days</th>
										<th data-name="days_since_batched" data-data="days_since_batched">Days With Officer</th>
										<th data-name="job_purpose" data-data="job_purpose">Purpose</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>












<!-- Completed Applications Modal -->
<div class="modal fade" id="completedapplicationsModal" tabindex="-1" aria-labelledby="completedApplicationsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completedApplicationsModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-hover" id="completedApplicationsTable" style="width: 100%">
                                <thead class="table-light">
                                    <tr>
                                        <th>Job Number</th>
                                        <th>Applicant Name</th>
                                        <th>Application Type</th>
                                        <th>Submission Date</th>
                                        <th>Completed Date</th>
                                        <th>TAT</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Data will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<!-- Send Message Modal-->
<div class="modal fade effect-scale modal-blur" id="sendMessageModal" tabindex="-1" aria-labelledby="sendMessageModalLabel" style="z-index: 1029;" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title fw-semibold mb-0" id="sendMessageModalLabel">
                        <i class="ri-message-2-line me-2 text-primary"></i>
                        <span id="modalTitleText">Send Message</span>
                    </h5>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <!-- Recipient Info Card -->
                <div class="card border mb-4">
                    <div class="card-body py-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-md bg-primary bg-opacity-10 rounded-circle me-3">
                                <i class="ri-user-line text-primary fs-4"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-0 fw-semibold" id="recipientNameDisplay">Select a recipient</h6>
                                <small class="text-muted" id="recipientInfo">No recipient selected</small>
                            </div>
                            <div class="badge bg-light text-dark" id="jobCountBadge">0 jobs</div>
                        </div>
                    </div>
                </div>

                <!-- Message Form -->
                <form method="post" id="message-form" action="SendComplianceMessage" class="needs-validation" novalidate>
                    <input id="officer_id" name="officer_id" type="hidden"/>
                    <input id="request_type" name="request_type" value="send_compliance_message" type="hidden">
                    <input id="officer_name" name="officer_name" type="hidden"/>
                    <input id="job_numbers" name="job_numbers[]" type="hidden"/>

                    <!-- Message Type -->
                    <div class="mb-4">
                        <label for="message_type" class="form-label fw-medium">
                            <i class="ri-chat-1-line me-1 text-muted"></i>
                            Message Type
                            <span class="text-danger">*</span>
                        </label>
                        <div class="btn-group w-100" role="group" aria-label="Message type selection">
                            <input type="radio" class="btn-check" name="message_type" id="message_type_query" value="query" autocomplete="off" checked>
                            <label class="btn btn-outline-primary" for="message_type_query">
                                <i class="ri-question-line me-1"></i>Query
                            </label>
                            
                            <input type="radio" class="btn-check" name="message_type" id="message_type_message" value="message" autocomplete="off">
                            <label class="btn btn-outline-primary" for="message_type_message">
                                <i class="ri-message-2-line me-1"></i>Message
                            </label>
                            
                            <input type="radio" class="btn-check" name="message_type" id="message_type_reminder" value="reminder" autocomplete="off">
                            <label class="btn btn-outline-primary" for="message_type_reminder">
                                <i class="ri-alarm-warning-line me-1"></i>Reminder
                            </label>
                        </div>
                        <div class="form-text">
                            <i class="ri-information-line me-1"></i>
                            Select the type of message you want to send
                        </div>
                    </div>

                    <!-- Message Content -->
                    <div class="mb-4">
                        <label for="message" class="form-label fw-medium">
                            <i class="ri-chat-quote-line me-1 text-muted"></i>
                            Message Content
                            <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <textarea class="form-control" name="message" id="message" 
                                      rows="5" placeholder="Type your message here..." 
                                      required style="resize: none;"></textarea>
                            <span class="input-group-text bg-light align-items-start">
                                <i class="ri-pencil-line text-muted"></i>
                            </span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-2">
                            <div class="form-text">
                                <i class="ri-information-line me-1"></i>
                                Write your message to the recipient
                            </div>
                            <small class="text-muted" id="charCount">0/1000 characters</small>
                        </div>
                    </div>

                    <!-- Template Suggestions (Optional) -->
                    <div class="mb-4">
                        <label class="form-label fw-medium">
                            <i class="ri-stack-line me-1 text-muted"></i>
                            Quick Templates
                        </label>
                        <div class="d-flex flex-wrap gap-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="query">
                                <i class="ri-question-line me-1"></i>Urgent Query
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="followup">
                                <i class="ri-time-line me-1"></i>Follow-up Required
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="reminder">
                                <i class="ri-alarm-warning-line me-1"></i>TAT Reminder
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="update">
                                <i class="ri-refresh-line me-1"></i>Status Update
                            </button>
                        </div>
                    </div>

                    <!-- Preview Section -->
                    <div class="card border mb-4" id="previewCard" style="display: none;">
                        <div class="card-header bg-light">
                            <h6 class="mb-0 fw-semibold">
                                <i class="ri-eye-line me-2"></i>Message Preview
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-light border" id="messagePreview">
                                <small class="text-muted">Preview will appear here</small>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                            <i class="ri-close-line me-1"></i>Cancel
                        </button>
                        <button type="reset" class="btn btn-outline-warning" id="btnResetForm">
                            <i class="ri-refresh-line me-1"></i>Reset
                        </button>
                        <button type="submit" class="btn btn-primary flex-grow-1" id="btnSubmitMessage">
                            <i class="ri-send-plane-line me-1"></i>
                            <span id="submitButtonText">Send Message</span>
                            <span class="spinner-border spinner-border-sm ms-2 d-none" id="loadingSpinner" role="status" aria-hidden="true"></span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>





<div class="modal fade"
     data-position="0"
     id="sendMessageModal_FocalCompliance"
     tabindex="-1"
     aria-labelledby="sendMessageModalLabel_FocalCompliance"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title"
                    id="sendMessageModalLabel_FocalCompliance"></h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <form method="post"
                      id="message-form_focal_complaince"
                      action="SendComplianceMessage">

                    <!-- Hidden Inputs -->
                    <input type="hidden" id="focal_officer_id" name="officer_id">
                    <input type="hidden" id="request_type"
                           name="request_type"
                           value="send_compliance_focal_person_message">
                    <input type="hidden" id="officer_name" name="officer_name">
                    <input type="hidden" id="job_numbers" name="job_numbers[]">

                    <!-- Message Type -->
                    <div class="mb-3">
                        <label for="message_type" class="form-label">
                            Message Type
                        </label>
                        <select required
                                class="form-select"
                                name="message_type"
                                id="message_type">
                            <option value="">Select One</option>
                            <option value="message">Message</option>
                            <!-- <option value="warning">Warning</option> -->
                        </select>
                    </div>

                    <!-- Message -->
                    <div class="mb-3">
                        <label for="message" class="form-label">
                            Message
                        </label>
                        <textarea required
                                  class="form-control"
                                  name="message"
                                  id="message"
                                  rows="4"></textarea>
                    </div>

                    <!-- Submit -->
                    <div class="text-end">
                        <button type="submit"
                                class="btn btn-primary">
                            Submit
                        </button>
                        <button type="button"
                                class="btn btn-secondary ms-2"
                                data-bs-dismiss="modal">
                            Cancel
                        </button>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>












<div class="modal fade"
     data-position="0"
     id="past_due_apps_modal"
     tabindex="-1"
     aria-labelledby="past_due_apps_Label"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="past_due_apps_Label"></h5>

                <!-- Optional action button -->
                <!-- <button class="btn btn-primary ms-auto me-2" id="send_message" type="button">Send Message</button> -->

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table id="past_due_apps_with_staff"
                                   class="table"
                                   style="width: 100%"
                                   data-responsive="true"
                                   data-order='[[ 1, "desc" ]]'
                                   data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-center'B><'col-sm-4 text-end'f>>
                                             <'row'<'col-sm-12'tr>>
                                             <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>"
                                   data-buttons='{
                                       "buttons": [
                                           { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                                           { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                                           "colvis"
                                       ]
                                   }'>
                                <thead>
                                    <tr>
                                        <th>Job Number</th>
                                        <th>Applicant Name</th>
                                        <th>Application Type</th>
                                        <th>Submission Date</th>
                                        <th>Date Received by Officer</th>
                                        <th>Pending Days</th>
                                        <th>Days With Officer</th>
                                        <th>Purpose</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>

                        <div class="col-12 mt-3">
                            <div class="chart"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <form class="generate-applications-chart row g-2 align-items-center w-100">
                    <div class="col-auto">
                        <label for="chart_type" class="col-form-label">
                            Generate Chart
                        </label>
                    </div>

                    <div class="col-auto">
                        <select class="form-select"
                                name="chart_type"
                                id="chart_type">
                            <option value="">Select One</option>
                            <option value="pie">Pie Chart</option>
                            <option value="doughnut">Doughnut Chart</option>
                            <option value="bar">Bar Chart</option>
                        </select>
                    </div>

                    <div class="col-auto ms-auto">
                        <button type="submit" class="btn btn-primary">
                            Generate
                        </button>
                        <button type="button"
                                class="btn btn-danger ms-2 clear-chart">
                            Clear
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>








<div class="modal fade" 
     data-position="0" 
     id="apps_with_division_officers_modal" 
     tabindex="-1" 
     aria-labelledby="apps_with_division_officers_Label" 
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="apps_with_division_officers_Label"></h5>

                <!-- Optional action button -->
                <!-- <button class="btn btn-primary ms-auto me-2" id="send_message" type="button">Send Message</button> -->

                <button type="button" 
                        class="btn-close" 
                        data-bs-dismiss="modal" 
                        aria-label="Close">
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">

                        <!-- DataTable -->
                        <div class="col-12 table-responsive">
                            <table id="apps_with_division_officers_table"
                                   class="table"
                                   style="width: 100%"
                                   data-responsive="true"
                                   data-order='[[ 1, "desc" ]]'
                                   data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-center'B><'col-sm-4 text-end'f>>
                                             <'row'<'col-sm-12'tr>>
                                             <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>"
                                   data-buttons='{
                                       "buttons": [
                                           { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                                           { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                                           "colvis"
                                       ]
                                   }'>
                                <thead>
                                    <tr>
                                        <th>Job Number</th>
                                        <th>Applicant Name</th>
                                        <th>Application Type</th>
                                        <th>Submission Date</th>
                                        <th>Date Received by Officer</th>
                                        <th>Pending Days</th>
                                        <th>Days With Officer</th>
                                        <th>Purpose</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>

                        <!-- Chart Container -->
                        <div class="col-12 mt-3">
                            <div class="chart"></div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <form class="generate-applications-chart row g-2 align-items-center w-100">
                    <div class="col-auto">
                        <label for="chart_type" class="col-form-label">Generate Chart</label>
                    </div>

                    <div class="col-auto">
                        <select class="form-select" name="chart_type" id="chart_type">
                            <option value="">Select One</option>
                            <option value="pie">Pie Chart</option>
                            <option value="doughnut">Doughnut Chart</option>
                            <option value="bar">Bar Chart</option>
                        </select>
                    </div>

                    <div class="col-auto ms-auto">
                        <button type="submit" class="btn btn-primary">Generate</button>
                        <button type="button" class="btn btn-danger ms-2 clear-chart">Clear</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
