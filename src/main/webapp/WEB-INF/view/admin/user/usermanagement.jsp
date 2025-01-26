<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="fixed">
<head>

    <!-- Basic -->
    <meta charset="UTF-8">

    <title>Dashboard | JSOFT Themes | JSOFT-Admin</title>
    <meta name="keywords" content="HTML5 Admin Template" />
    <meta name="description" content="JSOFT Admin - Responsive HTML5 Template">
    <meta name="author" content="JSOFT.net">

    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

    <!-- Web Fonts  -->
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800|Shadows+Into+Light" rel="stylesheet" type="text/css">

    <!-- Vendor CSS -->
    <link rel="stylesheet" href="/client/auth/assets/vendor/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="/client/auth/assets/vendor/font-awesome/css/font-awesome.css" />
    <link rel="stylesheet" href="/client/auth/assets/vendor/magnific-popup/magnific-popup.css" />
    <link rel="stylesheet" href="/client/auth/assets/vendor/bootstrap-datepicker/css/datepicker3.css" />

    <!-- Specific Page Vendor CSS -->
    <link rel="stylesheet" href="/client/auth/assets/vendor/jquery-ui/css/ui-lightness/jquery-ui-1.10.4.custom.css" />
    <link rel="stylesheet" href="/client/auth/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.css" />
    <link rel="stylesheet" href="/client/auth/assets/vendor/morris/morris.css" />

    <!-- Theme CSS -->
    <link rel="stylesheet" href="/client/auth/assets/stylesheets/theme.css" />

    <!-- Skin CSS -->
    <link rel="stylesheet" href="/client/auth/assets/stylesheets/skins/default.css" />

    <!-- Theme Custom CSS -->
    <link rel="stylesheet" href="/client/auth/assets/stylesheets/theme-custom.css">

    <!-- Head Libs -->
    <script src="/client/auth/assets/vendor/modernizr/modernizr.js"></script>

</head>
<body>

<section class="body">

    <!-- start: header -->
    <jsp:include page="../layout/header.jsp" />
    <!-- end: header -->

    <div class="inner-wrapper">
        <!-- start: sidebar -->
        <jsp:include page="../layout/sidebar.jsp" />
        <!-- end: sidebar -->

        <section role="main" class="content-body">
            <header class="page-header">
                <h2><i class="fa fa-users mr-xs"></i> User Management</h2>
                <div class="right-wrapper pull-right">
                    <ol class="breadcrumbs">
                        <li>
                            <a href="/">
                                <i class="fa fa-home"></i>
                            </a>
                        </li>
                        <li><span>User Management</span></li>
                    </ol>
                    <a class="sidebar-right-toggle" data-open="sidebar-right"><i class="fa fa-chevron-left"></i></a>
                </div>
            </header>

            <div class="row">
                <div class="col-md-12">
                    <section class="panel panel-featured panel-featured-primary">
                        <header class="panel-heading">
                            <div class="panel-actions">
                                <a href="#" class="panel-action panel-action-toggle" data-panel-toggle></a>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <h2 class="panel-title"><i class="fa fa-list-alt mr-xs"></i>User List</h2>
                                </div>
                                <div class="col-sm-6">
                                    <div class="pull-right">
                                        <form id="search-form" action="usermanagement" method="get" class="search nav-form">
                                            <div class="input-group input-search">
                                                <input type="text" class="form-control" name="input" 
                                                       placeholder="Search by name or phone..." value="${input}" required>
                                                <span class="input-group-btn">
                                                    <button class="btn btn-primary" type="submit">
                                                        <i class="fa fa-search"></i>
                                                    </button>
                                                </span>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </header>
                        
                        <div class="panel-body">
                            <div class="row mb-md">
                                <div class="col-sm-6">
                                    <form action="usermanagement" method="get" class="form-inline">
                                        <c:if test="${sessionScope.user.role.id == 1}">
                                            <div class="form-group mr-md">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-user-circle"></i></span>
                                                    <select id="role" name="role" class="form-control">
                                                        <option ${roleId == -1 ? "selected" : ""} value="-1" >All Roles</option>
                                                        <option ${roleId == 1 ? "selected" : ""} value="1">Admin</option>
                                                        <option ${roleId == 2 ? "selected" : ""} value="2">Owner</option>
                                                        <option ${roleId == 3 ? "selected" : ""} value="3">Staff</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group mr-md">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-toggle-on"></i></span>
                                                    <select id="active" name="active" class="form-control">
                                                        <option ${active == -1 ? "selected" : ""} value="-1">All Status</option>
                                                        <option ${active == 1 ? "selected" : ""} value="1">Active</option>
                                                        <option ${active == 0 ? "selected" : ""} value="0">Banned</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary"><i class="fa fa-filter mr-xs"></i>Filter</button>
                                        </c:if>
<%--                                        <c:if test="${sessionScope.user.role.id == 2}">--%>
<%--                                            <select id="store" name="store" class="form-control">--%>
<%--                                                <option value="0">All Status</option>--%>
<%--                                                <c:forEach items="${stores}" var="s">--%>
<%--                                                    <option value="${s.id}">${s.name}</option>--%>
<%--                                                </c:forEach>--%>
<%--                                            </select>--%>
<%--                                        </c:if>--%>

                                    </form>
                                </div>
                                <div class="col-sm-6">
                                    <div class="pull-right">
                                        <button class="btn btn-primary mb-xs mt-xs mr-xs">
                                            <i class="fa fa-plus mr-xs"></i>Add User
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-bordered table-striped table-hover mb-none">
                                    <thead>
                                        <tr>
                                            <th><i class="fa fa-user mr-xs"></i>Name</th>
                                            <th><i class="fa fa-phone mr-xs"></i>Phone</th>
                                            <c:if test="${sessionScope.user.role.id == 1}">
                                                <th><i class="fa fa-users mr-xs"></i>Role</th>
                                                <th><i class="fa fa-check-circle mr-xs"></i>Status</th>
                                            </c:if>
                                            <th><i class="fa fa-cogs mr-xs"></i>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="u" items="${userPage.content}">
                                            <tr>
                                                <td><strong>${u.name}</strong></td>
                                                <td>${u.phone}</td>
                                                <c:if test="${sessionScope.user.role.id == 1}">
                                                    <td><span class="text-primary">${u.role.name}</span></td>
                                                    <td>
                                                        <span class="label ${u.active == 'true' ? 'label-success' : 'label-danger'} label-sm status-label">
                                                            <i class="fa ${u.active == 'true' ? 'fa-check' : 'fa-ban'} mr-xs"></i>
                                                            ${u.active == "true" ? "Active" : "Banned"}
                                                        </span>
                                                    </td>
                                                </c:if>
                                                <td>
                                                    <button id="view-button" class="btn btn-default btn-sm mr-xs" title="View ">
                                                        <i class="fa fa-eye"></i>
                                                    </button>
                                                    <button id="update-button"class="btn btn-primary btn-sm" title="Update">
                                                        <i class="fa fa-pencil"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <c:set var="c" value="${userPage.number}"></c:set>
                                <ul class="pagination justify-content-center" style="margin-leftgit:413px">
                                    <li class="page-item ${c==0 ?'disabled':''} ">
                                        <a class="page-link" href="usermanagement?page=${c - 1}">Previous</a>
                                    </li>

                                    <c:forEach begin="0" end="${userPage.totalPages - 1}" var="i">
                                        <c:if test="${i >= c - 1 && i <= c + 1}">
                                            <li class="page-item ${c == i ? 'active' : ''}">
                                                <a class="page-link" href="usermanagement?page=${i}">${i + 1}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${i == c- 2 || i == c+ 2}">
                                            <li><span>...</span></li>
                                        </c:if>
                                    </c:forEach>



                                    <li class="page-item ${c== userPage.totalPages -1?'disabled':''} ">
                                        <a class="page-link" href="usermanagement?page=${c + 1}">Next</a>
                                    </li>

                                </ul>

                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </section>

    </div>
</section>

<style>
    .panel-featured-primary {
        border-color: #0088cc;
    }
    .panel-featured-primary .panel-heading {
        background-color: #0088cc;
        color: #FFF;
        border-radius: 5px 5px 0 0;
    }
    .input-group-addon {
        background-color: #0088cc;
        color: #FFF;
        border-color: #0088cc;
    }
    .table > thead > tr > th {
        background-color: #f5f5f5;
        border-bottom: 2px solid #0088cc;
    }
    .btn-primary {
        background-color: #0088cc;
        border-color: #0088cc;
    }
    .btn-primary:hover {
        background-color: #006699;
        border-color: #006699;
    }
    .label-sm {
        font-size: 90%;
        padding: 3px 8px;
    }
    .mr-xs {
        margin-right: 5px;
    }
    .mb-xs {
        margin-bottom: 5px;
    }
    .mt-xs {
        margin-top: 5px;
    }
    .status-label {
        display: inline-block;
        min-width: 85px;
        text-align: center;
        padding: 5px 10px;
    }
    .pagination {
        margin: 20px auto;
        display: inline-flex;
        justify-content: center;
        padding-left: 0;
    }
</style>

<script>
    document.getElementById("search-input").addEventListener("keypress",function(event){
        if(event.key === "Enter"){
            event.preventDefault();
            document.getElementById("search-form").submit();
        }
    });
    // document.getElementById("view-button").addEventListener("click",function ());
</script>


<script src="/client/auth/assets/vendor/jquery/jquery.js"></script>
<script src="/client/auth/assets/vendor/jquery-browser-mobile/jquery.browser.mobile.js"></script>
<script src="/client/auth/assets/vendor/bootstrap/js/bootstrap.js"></script>
<script src="/client/auth/assets/vendor/nanoscroller/nanoscroller.js"></script>
<script src="/client/auth/assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script src="/client/auth/assets/vendor/magnific-popup/magnific-popup.js"></script>
<script src="/client/auth/assets/vendor/jquery-placeholder/jquery.placeholder.js"></script>

<script src="/client/auth/assets/vendor/jquery-ui/js/jquery-ui-1.10.4.custom.js"></script>
<script src="/client/auth/assets/vendor/jquery-ui-touch-punch/jquery.ui.touch-punch.js"></script>
<script src="/client/auth/assets/vendor/jquery-appear/jquery.appear.js"></script>
<script src="/client/auth/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.js"></script>
<script src="/client/auth/assets/vendor/jquery-easypiechart/jquery.easypiechart.js"></script>
<script src="/client/auth/assets/vendor/flot/jquery.flot.js"></script>
<script src="/client/auth/assets/vendor/flot-tooltip/jquery.flot.tooltip.js"></script>
<script src="/client/auth/assets/vendor/flot/jquery.flot.pie.js"></script>
<script src="/client/auth/assets/vendor/flot/jquery.flot.categories.js"></script>
<script src="/client/auth/assets/vendor/flot/jquery.flot.resize.js"></script>
<script src="/client/auth/assets/vendor/jquery-sparkline/jquery.sparkline.js"></script>
<script src="/client/auth/assets/vendor/raphael/raphael.js"></script>
<script src="/client/auth/assets/vendor/morris/morris.js"></script>
<script src="/client/auth/assets/vendor/gauge/gauge.js"></script>
<script src="/client/auth/assets/vendor/snap-svg/snap.svg.js"></script>
<script src="/client/auth/assets/vendor/liquid-meter/liquid.meter.js"></script>
<script src="/client/auth/assets/vendor/jqvmap/jquery.vmap.js"></script>
<script src="/client/auth/assets/vendor/jqvmap/data/jquery.vmap.sampledata.js"></script>
<script src="/client/auth/assets/vendor/jqvmap/maps/jquery.vmap.world.js"></script>
<script src="/client/auth/assets/vendor/jqvmap/maps/continents/jquery.vmap.africa.js"></script>
<script src="/client/auth/assets/vendor/jqvmap/maps/continents/jquery.vmap.asia.js"></script>
<script src="/client/auth/assets/vendor/jqvmap/maps/continents/jquery.vmap.australia.js"></script>
<script src="/client/auth/assets/vendor/jqvmap/maps/continents/jquery.vmap.europe.js"></script>
<script src="/client/auth/assets/vendor/jqvmap/maps/continents/jquery.vmap.north-america.js"></script>
<script src="/client/auth/assets/vendor/jqvmap/maps/continents/jquery.vmap.south-america.js"></script>

<!-- Theme Base, Components and Settings -->
<script src="/client/auth/assets/javascripts/theme.js"></script>

<!-- Theme Custom -->
<script src="/client/auth/assets/javascripts/theme.custom.js"></script>

<!-- Theme Initialization Files -->
<script src="/client/auth/assets/javascripts/theme.init.js"></script>


<!-- Examples -->
<script src="/client/auth/assets/javascripts/dashboard/examples.dashboard.js"></script>
</body>
</html>