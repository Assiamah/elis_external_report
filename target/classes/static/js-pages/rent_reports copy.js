// Chart instances
let trendChart = null;
let distributionChart = null;
let performanceChart = null;
let customRangeModal = null;
let customDateFrom = null;
let customDateTo = null;

// Initialize date pickers
flatpickr("#start_date", {
    dateFormat: "Y-m-d",
    defaultDate: "2025-01-01"
});

flatpickr("#end_date", {
    dateFormat: "Y-m-d",
    defaultDate: "2025-02-28"
});

// Initialize all charts when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    initTrendChart();
    initDistributionChart();
    initPerformanceChart();
    initResponsiveCharts();
    
    // Initialize custom range modal HTML
    createCustomRangeModal();
});

// Rent Collection Trend Chart (Line Chart)
function initTrendChart() {
    const chartDom = document.getElementById('rent-collection-trend');
    if (!chartDom) return;
    
    trendChart = echarts.init(chartDom);
    
    const option = {
        tooltip: {
            trigger: 'axis',
            backgroundColor: 'rgba(255, 255, 255, 0.95)',
            borderColor: '#e4e6ef',
            borderWidth: 1,
            textStyle: {
                color: '#6c757d',
                fontSize: 12
            },
            axisPointer: {
                type: 'shadow',
                shadowStyle: {
                    color: 'rgba(150, 150, 150, 0.1)'
                }
            },
            formatter: function(params) {
                let result = `<div style="font-weight: 600; margin-bottom: 5px; color: #495057">${params[0].axisValue}</div>`;
                params.forEach(item => {
                    const icon = item.seriesName === 'Rent Collected' ? '●' : '●';
                    const color = item.color;
                    const value = 'GHS ' + item.value.toLocaleString();
                    result += `
                        <div style="display: flex; align-items: center; margin: 5px 0;">
                            <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%; background: ${color}; margin-right: 8px;"></span>
                            <span style="flex: 1; color: #6c757d">${item.seriesName}</span>
                            <span style="font-weight: 600; color: #495057">${value}</span>
                        </div>
                    `;
                });
                return result;
            }
        },
        legend: {
            top: 10,
            right: 10,
            itemWidth: 12,
            itemHeight: 12,
            textStyle: {
                fontSize: 12,
                color: '#6c757d'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            top: '15%',
            containLabel: true
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            axisLine: {
                lineStyle: {
                    color: '#e4e6ef'
                }
            },
            axisLabel: {
                color: '#6c757d',
                fontSize: 11
            }
        },
        yAxis: {
            type: 'value',
            name: 'Amount (GHS)',
            nameTextStyle: {
                color: '#6c757d',
                fontSize: 12,
                padding: [0, 0, 0, -40]
            },
            axisLine: {
                lineStyle: {
                    color: '#e4e6ef'
                }
            },
            axisLabel: {
                color: '#6c757d',
                fontSize: 11,
                formatter: function(value) {
                    if (value >= 1000000) {
                        return (value / 1000000).toFixed(1) + 'M';
                    } else if (value >= 1000) {
                        return (value / 1000).toFixed(0) + 'K';
                    }
                    return value;
                }
            },
            splitLine: {
                lineStyle: {
                    color: '#f2f6f7',
                    type: 'dashed'
                }
            }
        },
        series: [
            {
                name: 'Rent Collected',
                type: 'line',
                smooth: true,
                symbol: 'circle',
                symbolSize: 6,
                lineStyle: {
                    width: 3,
                    color: '#0d6efd'
                },
                itemStyle: {
                    color: '#0d6efd',
                    borderColor: '#ffffff',
                    borderWidth: 2
                },
                areaStyle: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                        { offset: 0, color: 'rgba(13, 110, 253, 0.3)' },
                        { offset: 1, color: 'rgba(13, 110, 253, 0.05)' }
                    ])
                },
                data: [45000, 52000, 48000, 61000, 58000, 72000, 68000, 75000, 82000, 78000, 85000, 92000]
            },
            {
                name: 'Rent Outstanding',
                type: 'line',
                smooth: true,
                symbol: 'circle',
                symbolSize: 6,
                lineStyle: {
                    width: 3,
                    color: '#dc3545'
                },
                itemStyle: {
                    color: '#dc3545',
                    borderColor: '#ffffff',
                    borderWidth: 2
                },
                areaStyle: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                        { offset: 0, color: 'rgba(220, 53, 69, 0.3)' },
                        { offset: 1, color: 'rgba(220, 53, 69, 0.05)' }
                    ])
                },
                data: [12000, 15000, 18000, 14000, 16000, 13000, 17000, 15000, 12000, 14000, 11000, 9000]
            }
        ]
    };
    
    trendChart.setOption(option);
}

// Rent Distribution Chart (Donut/Pie Chart)
function initDistributionChart() {
    const chartDom = document.getElementById('rent-distribution-chart');
    if (!chartDom) return;
    
    distributionChart = echarts.init(chartDom);
    
    const option = {
        tooltip: {
            trigger: 'item',
            backgroundColor: 'rgba(255, 255, 255, 0.95)',
            borderColor: '#e4e6ef',
            borderWidth: 1,
            textStyle: {
                color: '#6c757d',
                fontSize: 12
            },
            formatter: function(params) {
                const amount = (params.value * 1000).toLocaleString();
                return `
                    <div style="font-weight: 600; margin-bottom: 5px; color: #495057">${params.name}</div>
                    <div style="display: flex; align-items: center;">
                        <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%; background: ${params.color}; margin-right: 8px;"></span>
                        <span style="color: #6c757d">Percentage: </span>
                        <span style="font-weight: 600; margin-left: 5px; color: #495057">${params.percent}%</span>
                    </div>
                    <div style="margin-top: 5px; color: #6c757d">Amount: <span style="font-weight: 600; color: #495057">GHS ${amount}</span></div>
                `;
            }
        },
        legend: {
            show: false
        },
        series: [
            {
                name: 'Rent Distribution',
                type: 'pie',
                radius: ['40%', '70%'],
                center: ['50%', '50%'],
                avoidLabelOverlap: false,
                itemStyle: {
                    borderRadius: 8,
                    borderColor: '#fff',
                    borderWidth: 2
                },
                label: {
                    show: false
                },
                emphasis: {
                    label: {
                        show: true,
                        fontSize: '14',
                        fontWeight: 'bold',
                        formatter: '{b}\n{c}%'
                    }
                },
                labelLine: {
                    show: false
                },
                data: [
                    { value: 44, name: 'East Legon Estates', itemStyle: { color: '#0d6efd' } },
                    { value: 35, name: 'Airport Residential', itemStyle: { color: '#198754' } },
                    { value: 28, name: 'Cantonments', itemStyle: { color: '#ffc107' } },
                    { value: 15, name: 'Other Estates', itemStyle: { color: '#0dcaf0' } }
                ]
            }
        ]
    };
    
    distributionChart.setOption(option);
}

// Performance Analysis Chart (Bar Chart)
function initPerformanceChart() {
    const chartDom = document.getElementById('performance-analysis-chart');
    if (!chartDom) return;
    
    performanceChart = echarts.init(chartDom);
    
    const option = {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            },
            backgroundColor: 'rgba(255, 255, 255, 0.95)',
            borderColor: '#e4e6ef',
            borderWidth: 1,
            textStyle: {
                color: '#6c757d',
                fontSize: 12
            },
            formatter: function(params) {
                let result = `<div style="font-weight: 600; margin-bottom: 5px; color: #495057">${params[0].axisValue}</div>`;
                params.forEach(item => {
                    const color = item.color;
                    const value = item.value + '%';
                    result += `
                        <div style="display: flex; align-items: center; margin: 5px 0;">
                            <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%; background: ${color}; margin-right: 8px;"></span>
                            <span style="flex: 1; color: #6c757d">${item.seriesName}</span>
                            <span style="font-weight: 600; color: #495057">${value}</span>
                        </div>
                    `;
                });
                return result;
            }
        },
        legend: {
            top: 10,
            right: 10,
            itemWidth: 12,
            itemHeight: 12,
            textStyle: {
                fontSize: 12,
                color: '#6c757d'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            top: '15%',
            containLabel: true
        },
        xAxis: {
            type: 'category',
            data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            axisLine: {
                lineStyle: {
                    color: '#e4e6ef'
                }
            },
            axisLabel: {
                color: '#6c757d',
                fontSize: 11
            }
        },
        yAxis: {
            type: 'value',
            name: 'Collection Rate (%)',
            nameTextStyle: {
                color: '#6c757d',
                fontSize: 12,
                padding: [0, 0, 0, -40]
            },
            axisLine: {
                lineStyle: {
                    color: '#e4e6ef'
                }
            },
            axisLabel: {
                color: '#6c757d',
                fontSize: 11,
                formatter: '{value}%'
            },
            splitLine: {
                lineStyle: {
                    color: '#f2f6f7',
                    type: 'dashed'
                }
            }
        },
        series: [
            {
                name: 'Target',
                type: 'bar',
                barWidth: '30%',
                itemStyle: {
                    color: 'rgba(13, 110, 253, 0.3)',
                    borderRadius: [4, 4, 0, 0]
                },
                data: [80, 85, 82, 88, 90, 92, 95]
            },
            {
                name: 'Actual',
                type: 'bar',
                barWidth: '30%',
                itemStyle: {
                    color: '#0d6efd',
                    borderRadius: [4, 4, 0, 0]
                },
                data: [75, 80, 78, 85, 87, 90, 93]
            }
        ]
    };
    
    performanceChart.setOption(option);
}

// Make charts responsive
function initResponsiveCharts() {
    window.addEventListener('resize', function() {
        if (trendChart) trendChart.resize();
        if (distributionChart) distributionChart.resize();
        if (performanceChart) performanceChart.resize();
    });
}

// Interactive functions
function setTimeRange(range) {
    const btn = document.querySelector('.btn-primary.dropdown-toggle');
    let text = 'This Month';
    
    switch(range) {
        case 'today':
            text = 'Today';
            break;
        case 'week':
            text = 'This Week';
            break;
        case 'month':
            text = 'This Month';
            break;
        case 'quarter':
            text = 'This Quarter';
            break;
        case 'year':
            text = 'This Year';
            break;
    }
    
    btn.innerHTML = `<i class="ri-calendar-line me-2"></i>${text}`;
    
    // Here you would typically fetch new data based on the selected range
    console.log('Time range changed to:', range);
}

function showCustomRange() {
    // Show the custom range modal
    if (!document.getElementById('customRangeModal')) {
        createCustomRangeModal();
    }
    
    customRangeModal = new bootstrap.Modal(document.getElementById('customRangeModal'), {
        keyboard: false,
        backdrop: 'static'
    });
    customRangeModal.show();
    
    initializeCustomDatePickers();
}

function createCustomRangeModal() {
    // Create modal element if it doesn't exist
    if (document.getElementById('customRangeModal')) return;
    
    const modalHTML = `
    <div class="modal fade" id="customRangeModal" tabindex="-1" aria-labelledby="customRangeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="customRangeModalLabel">Select Custom Date Range</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body">
                                    <label class="form-label fw-semibold">Date From</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-calendar-alt text-primary"></i>
                                        </span>
                                        <input type="text" id="datefrom" class="form-control" placeholder="Select Date From">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body">
                                    <label class="form-label fw-semibold">Date To</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-calendar-alt text-primary"></i>
                                        </span>
                                        <input type="text" id="dateto" class="form-control" placeholder="Select Date To">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Preset date ranges -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <label class="form-label fw-semibold">Quick Select</label>
                            <div class="d-flex flex-wrap gap-2">
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('today')">
                                    Today
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('yesterday')">
                                    Yesterday
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('last7days')">
                                    Last 7 Days
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('last30days')">
                                    Last 30 Days
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('lastmonth')">
                                    Last Month
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('thisyear')">
                                    This Year
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Date validation -->
                    <div id="dateValidation" class="alert alert-danger d-none" role="alert">
                        <i class="ri-alert-line me-2"></i>
                        <span id="validationMessage"></span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="applyCustomRange" onclick="applyCustomRange()">
                        <i class="ri-check-line me-1"></i>Apply Range
                    </button>
                </div>
            </div>
        </div>
    </div>
    `;
    
    document.body.insertAdjacentHTML('beforeend', modalHTML);
    
    // Add modal event listeners
    document.getElementById('customRangeModal').addEventListener('hidden.bs.modal', function() {
        document.getElementById('dateValidation').classList.add('d-none');
    });
}

function initializeCustomDatePickers() {
    // Destroy existing instances
    if (customDateFrom) {
        customDateFrom.destroy();
    }
    if (customDateTo) {
        customDateTo.destroy();
    }
    
    // Initialize date pickers
    customDateFrom = flatpickr("#datefrom", {
        dateFormat: "Y-m-d",
        defaultDate: new Date(new Date().setMonth(new Date().getMonth() - 1)),
        maxDate: "today",
        onChange: function(selectedDates, dateStr) {
            if (customDateTo) {
                customDateTo.set('minDate', dateStr);
            }
            validateDateRange();
        }
    });
    
    customDateTo = flatpickr("#dateto", {
        dateFormat: "Y-m-d",
        defaultDate: "today",
        maxDate: "today",
        onChange: function(selectedDates, dateStr) {
            if (customDateFrom) {
                customDateFrom.set('maxDate', dateStr);
            }
            validateDateRange();
        }
    });
    
    // Set initial min/max
    customDateTo.set('minDate', customDateFrom.input.value);
    customDateFrom.set('maxDate', customDateTo.input.value);
}


function setQuickRange(rangeType) {
    console.log('setQuickRange called with:', rangeType);
    
    const today = new Date();
    console.log('Today:', today);
    
    let fromDate, toDate;
    
    switch(rangeType) {
        case 'today':
            fromDate = new Date(today);
            toDate = new Date(today);
            break;
        case 'yesterday':
            const yesterday = new Date(today);
            yesterday.setDate(today.getDate() - 1);
            fromDate = yesterday;
            toDate = new Date(yesterday);
            break;
        case 'last7days':
            const sevenDaysAgo = new Date(today);
            sevenDaysAgo.setDate(today.getDate() - 6);
            fromDate = sevenDaysAgo;
            toDate = new Date(today);
            break;
        case 'last30days':
            const thirtyDaysAgo = new Date(today);
            thirtyDaysAgo.setDate(today.getDate() - 29);
            fromDate = thirtyDaysAgo;
            toDate = new Date(today);
            break;
        case 'thismonth':
            fromDate = new Date(today.getFullYear(), today.getMonth(), 1);
            toDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
            break;
        case 'lastmonth':
            const lastMonthYear = today.getMonth() === 0 ? today.getFullYear() - 1 : today.getFullYear();
            const lastMonth = today.getMonth() === 0 ? 11 : today.getMonth() - 1;
            fromDate = new Date(lastMonthYear, lastMonth, 1);
            toDate = new Date(lastMonthYear, lastMonth + 1, 0);
            break;
        case 'thisquarter':
            const quarter = Math.floor((today.getMonth() + 3) / 3);
            const startMonth = (quarter - 1) * 3;
            fromDate = new Date(today.getFullYear(), startMonth, 1);
            toDate = new Date(today.getFullYear(), startMonth + 3, 0);
            break;
        case 'thisyear':
            fromDate = new Date(today.getFullYear(), 0, 1);
            toDate = new Date(today.getFullYear(), 11, 31);
            break;
        default:
            const defaultDaysAgo = new Date(today);
            defaultDaysAgo.setDate(today.getDate() - 29);
            fromDate = defaultDaysAgo;
            toDate = new Date(today);
    }
    
    console.log(`Calculated dates - From: ${fromDate}, To: ${toDate}`);
    console.log(`Formatted - From: ${fromDate.toISOString().split('T')[0]}, To: ${toDate.toISOString().split('T')[0]}`);
    
    // Set dates in the date pickers
    if (customDateFrom && customDateTo) {
        console.log('Setting dates in pickers...');
        customDateFrom.setDate(fromDate, true);
        customDateTo.setDate(toDate, true);
        console.log('Dates set successfully');
        
        // Force update the input fields
        document.getElementById('datefrom').value = fromDate.toISOString().split('T')[0];
        document.getElementById('dateto').value = toDate.toISOString().split('T')[0];
    } else {
        console.error('Date pickers not initialized');
    }
    
    // Validate
    validateDateRange();
}


function validateDateRange() {
    const dateFrom = document.getElementById('datefrom').value;
    const dateTo = document.getElementById('dateto').value;
    const validationDiv = document.getElementById('dateValidation');
    const validationMessage = document.getElementById('validationMessage');
    
    if (!dateFrom || !dateTo) {
        validationDiv.classList.remove('d-none');
        validationMessage.textContent = 'Please select both start and end dates';
        document.getElementById('applyCustomRange').disabled = true;
        return false;
    }
    
    const fromDate = new Date(dateFrom);
    const toDate = new Date(dateTo);
    
    if (fromDate > toDate) {
        validationDiv.classList.remove('d-none');
        validationMessage.textContent = 'Start date cannot be later than end date';
        document.getElementById('applyCustomRange').disabled = true;
        return false;
    }
    
    // Hide validation and enable button
    validationDiv.classList.add('d-none');
    document.getElementById('applyCustomRange').disabled = false;
    return true;
}

function applyCustomRange() {
    if (!validateDateRange()) {
        return;
    }
    
    const dateFrom = document.getElementById('datefrom').value;
    const dateTo = document.getElementById('dateto').value;
    
    // Update the main dropdown button text
    const btn = document.querySelector('.btn-primary.dropdown-toggle');
    const fromFormatted = formatDateForDisplay(dateFrom);
    const toFormatted = formatDateForDisplay(dateTo);
    btn.innerHTML = `<i class="ri-calendar-line me-2"></i>${fromFormatted} - ${toFormatted}`;
    
    // Close modal
    if (customRangeModal) {
        customRangeModal.hide();
    }
    
    // Fetch data for custom range
    fetchDataForCustomRange(dateFrom, dateTo);
}

function formatDateForDisplay(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { 
        month: 'short', 
        day: 'numeric',
        year: 'numeric'
    });
}

function fetchDataForCustomRange(startDate, endDate) {
    console.log('Fetching data for custom range:', startDate, 'to', endDate);
    
    // Show loading state
    showLoading(true);
    
    // Simulate API call
    setTimeout(() => {
        updateChartsWithCustomRange(startDate, endDate);
        showLoading(false);
        showToast('Custom date range applied successfully', 'success');
    }, 1000);
}

function showLoading(show) {
    if (show) {
        // Create loading overlay
        const overlay = document.createElement('div');
        overlay.id = 'loadingOverlay';
        overlay.className = 'position-fixed top-0 start-0 w-100 h-100 d-flex justify-content-center align-items-center bg-dark bg-opacity-25 z-1050';
        overlay.innerHTML = `
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        `;
        document.body.appendChild(overlay);
    } else {
        const overlay = document.getElementById('loadingOverlay');
        if (overlay) {
            overlay.remove();
        }
    }
}

function updateChartsWithCustomRange(startDate, endDate) {
    // Convert dates to Date objects
    const start = new Date(startDate);
    const end = new Date(endDate);
    
    // Calculate months difference
    const monthsDiff = (end.getFullYear() - start.getFullYear()) * 12 + (end.getMonth() - start.getMonth());
    
    // Update trend chart
    if (trendChart) {
        let labels = [];
        let collectedData = [];
        let outstandingData = [];
        
        if (monthsDiff <= 1) {
            // Daily data for 1 month or less
            const daysDiff = Math.ceil((end - start) / (1000 * 60 * 60 * 24));
            for (let i = 0; i <= daysDiff; i++) {
                const date = new Date(start);
                date.setDate(start.getDate() + i);
                labels.push(date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' }));
                collectedData.push(Math.floor(Math.random() * 50000) + 20000);
                outstandingData.push(Math.floor(Math.random() * 20000) + 5000);
            }
        } else if (monthsDiff <= 6) {
            // Weekly data for up to 6 months
            const weeksDiff = Math.ceil(monthsDiff * 4.33);
            for (let i = 0; i < weeksDiff; i++) {
                labels.push(`Week ${i + 1}`);
                collectedData.push(Math.floor(Math.random() * 150000) + 50000);
                outstandingData.push(Math.floor(Math.random() * 50000) + 10000);
            }
        } else {
            // Monthly data for more than 6 months
            for (let i = 0; i <= monthsDiff; i++) {
                const date = new Date(start);
                date.setMonth(start.getMonth() + i);
                labels.push(date.toLocaleDateString('en-US', { month: 'short', year: 'numeric' }));
                collectedData.push(Math.floor(Math.random() * 300000) + 100000);
                outstandingData.push(Math.floor(Math.random() * 100000) + 20000);
            }
        }
        
        trendChart.setOption({
            xAxis: {
                data: labels
            },
            series: [
                {
                    data: collectedData
                },
                {
                    data: outstandingData
                }
            ]
        });
    }
    
    console.log('Charts updated for custom range');
}

function showToast(message, type = 'info') {
    // Create toast
    const toastHTML = `
    <div class="toast-container position-fixed top-0 end-0 p-3">
        <div id="liveToast" class="toast align-items-center text-bg-${type} border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    <i class="ri-checkbox-circle-fill me-2"></i>
                    ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
    `;
    
    // Remove existing toasts
    const existingToasts = document.querySelectorAll('.toast-container');
    existingToasts.forEach(toast => toast.remove());
    
    // Add new toast
    document.body.insertAdjacentHTML('beforeend', toastHTML);
    
    // Show toast
    const toastEl = document.getElementById('liveToast');
    const toast = new bootstrap.Toast(toastEl);
    toast.show();
}

function changeTrendChartPeriod(period) {
    const btn = document.getElementById('trendChartPeriod');
    btn.textContent = period.charAt(0).toUpperCase() + period.slice(1);
    
    // Update chart data based on period
    console.log('Chart period changed to:', period);
}

function refreshDistributionChart() {
    if (distributionChart) {
        distributionChart.showLoading();
        setTimeout(() => {
            distributionChart.hideLoading();
            console.log('Distribution chart refreshed');
        }, 500);
    }
}

function applyAnalysisFilter() {
    const filter = document.getElementById('analysis_filter').value;
    const startDate = document.getElementById('start_date').value;
    const endDate = document.getElementById('end_date').value;
    
    console.log('Applying filter:', {
        estate: filter,
        startDate: startDate,
        endDate: endDate
    });
    
    if (performanceChart) {
        performanceChart.showLoading();
        setTimeout(() => {
            performanceChart.hideLoading();
            console.log('Performance chart updated with filter');
        }, 500);
    }
}

function generatePerformanceReport() {
    console.log('Generating performance report...');
    alert('Performance report generation started. This would typically generate a PDF or Excel file.');
}

// Export report functionality
document.getElementById('exportReport').addEventListener('click', function() {
    if (trendChart) {
        const trendChartImage = trendChart.getDataURL({
            type: 'png',
            pixelRatio: 2,
            backgroundColor: '#fff'
        });
        
        const link = document.createElement('a');
        link.href = trendChartImage;
        link.download = 'rent-trend-chart.png';
        link.click();
    }
    
    console.log('Exporting dashboard report...');
});