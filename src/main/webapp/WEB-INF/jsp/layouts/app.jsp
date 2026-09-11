<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en" dir="ltr" data-nav-layout="vertical" data-theme-mode="light" data-header-styles="transparent" data-width="fullwidth" data-menu-styles="transparent" data-page-style="regular" data-toggled="icon-hover-closed" data-vertical-style="overlay" loader="enable" style="--primary-rgb: 9 ,124, 103;">

<head>

    <!-- Meta Data -->
    <meta charset="UTF-8">
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title> ELIS | GRA REPORT </title>
    <meta name="Description" content="">
    <meta name="Author" content="">
	<meta name="keywords" content="">
    
    <!-- include header-links.jsp"-->
    <jsp:include page="../components/_header-links.jsp"></jsp:include>

    <c:if test="${page_name eq 'gra_report'}">
        <style>
            body.gra-fullscreen-report {
                overflow-x: hidden;
            }

            body.gra-fullscreen-report .app-header,
            body.gra-fullscreen-report .app-sidebar,
            body.gra-fullscreen-report .footer,
            body.gra-fullscreen-report footer {
                display: none !important;
            }

            body.gra-fullscreen-report .main-content.app-content {
                width: 100% !important;
                max-width: 100% !important;
                min-height: 100vh;
                margin: 0 !important;
                margin-inline-start: 0 !important;
                padding: 0 !important;
                padding-block-start: 0 !important;
                padding-inline: 0 !important;
                inset-inline-start: 0 !important;
                transition: none !important;
            }

            body.gra-fullscreen-report .page {
                min-height: 100vh;
            }
        </style>
    </c:if>

</head>

<body class="${page_name eq 'gra_report' ? 'gra-fullscreen-report' : ''}">
	<div class="progress-top-bar"></div>

    <div id="page_name" style="display:none">${page_name}</div>
	<div id="page_ready" style="display:none"></div>
	<div id="regional_code_general" style="display:none">${regional_code}</div>
    
    <!-- include switcher.jsp"-->
    <c:if test="${page_name ne 'gra_report'}">
        <jsp:include page="../components/_switcher.jsp"></jsp:include>
    </c:if>

    <!-- include loader.jsp"-->
    <c:if test="${page_name ne 'gra_report'}">
        <jsp:include page="../components/_loader.jsp"></jsp:include>
    </c:if>

    <div class="page">

        <!-- include header.jsp"-->
        <c:if test="${page_name ne 'gra_report'}">
            <jsp:include page="../components/_header.jsp"></jsp:include>
        </c:if>

        <!-- include sidebar.jsp"-->

        <!-- Start::app-content -->
        <jsp:include page="${content}" />
        <!-- End::app-content -->

        <!-- include modal.jsp"-->
        <c:if test="${page_name ne 'gra_report'}">
            <jsp:include page="../components/_modal.jsp"></jsp:include>
        </c:if>
        <!-- <jsp:include page="../components/lrd_maps_modals.jsp"></jsp:include> -->


        <!-- include notifications.jsp"-->
        <c:if test="${page_name ne 'gra_report'}">
            <jsp:include page="../components/_notifications.jsp"></jsp:include>
        </c:if>

        <!-- include footer.jsp"-->
        <c:if test="${page_name ne 'gra_report'}">
            <jsp:include page="../components/_footer.jsp"></jsp:include>
        </c:if>

    </div>

    <!-- include commonjs.jsp"-->
    <jsp:include page="../components/_commonjs.jsp"></jsp:include>

    <script>
        window.logout = function() {

            event.preventDefault();

            Swal.fire({
                title: "Are you sure?",
                text: "You will be logged out of your session.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Yes, log me out",
                cancelButtonText: "Cancel",
                customClass: {
                    cancelButton: "btn btn-outline-dark",
                    confirmButton: "btn btn-danger"
                },
                buttonsStyling: false
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '${pageContext.request.contextPath}/Logout';
                }
            });
        }
    </script>
    
</body>

</html> 
