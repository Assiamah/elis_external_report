<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>

<style>
    .gra-report-page {
        --gra-green: #0d6733;
        --gra-green-dark: #06451f;
        --gra-green-soft: #eaf6ee;
        --gra-border: #e5ebea;
        --gra-text: #1f2933;
        --gra-muted: #687385;
        color: var(--gra-text);
        min-height: 100vh;
        min-height: 100dvh;
        width: 100%;
        overflow-x: hidden;
        padding: 0 22px 32px;
        background: #f6faf8;
    }

    .gra-hero {
        position: relative;
        overflow: hidden;
        min-height: 160px;
        border-radius: 0 0 4px 4px;
        padding: 28px 34px;
        background:
            radial-gradient(circle at 88% 12%, rgba(176, 222, 96, 0.22), transparent 28%),
            radial-gradient(circle at 62% 120%, rgba(36, 164, 88, 0.32), transparent 44%),
            linear-gradient(112deg, #043c1b 0%, #08602c 52%, #0d7839 100%);
        border: 1px solid rgba(255, 255, 255, 0.08);
        box-shadow:
            0 18px 42px rgba(6, 69, 31, 0.18),
            inset 0 1px 0 rgba(255, 255, 255, 0.12);
    }

    .gra-hero:before,
    .gra-hero:after {
        content: "";
        position: absolute;
        inset: auto -8% -45px -8%;
        height: 86px;
        background: rgba(124, 190, 61, 0.42);
        transform: rotate(-3deg);
    }

    .gra-hero:after {
        inset: auto -6% -62px 35%;
        height: 104px;
        background: rgba(22, 141, 66, 0.44);
        transform: rotate(7deg);
    }

    .gra-hero-content {
        position: relative;
        z-index: 2;
        display: flex;
        align-items: center;
        gap: 22px;
    }

    .gra-logo {
        width: 88px;
        height: 88px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.96);
        padding: 8px;
        object-fit: contain;
        box-shadow: 0 14px 30px rgba(0, 0, 0, 0.18);
    }

    .gra-hero h1 {
        margin: 0 0 6px;
        color: #ffffff;
        font-size: 38px;
        font-weight: 800;
        letter-spacing: 0;
    }

    .gra-hero p {
        margin: 0;
        color: rgba(255, 255, 255, 0.88);
        font-size: 16px;
    }

    .gra-hero-buildings {
        position: absolute;
        right: 26px;
        bottom: 16px;
        z-index: 1;
        display: flex;
        align-items: flex-end;
        gap: 8px;
        opacity: 0.26;
    }

    .gra-building {
        width: 46px;
        background: #d8ead8;
        clip-path: polygon(0 14%, 35% 14%, 35% 0, 68% 0, 68% 14%, 100% 14%, 100% 100%, 0 100%);
    }

    .gra-building:nth-child(1) { height: 86px; }
    .gra-building:nth-child(2) { height: 68px; clip-path: polygon(0 0, 100% 0, 100% 100%, 0 100%); }
    .gra-building:nth-child(3) { height: 102px; clip-path: polygon(0 100%, 0 18%, 45% 18%, 45% 0, 62% 0, 62% 18%, 100% 18%, 100% 100%); }

    .gra-shell {
        max-width: 100%;
        margin: 28px auto 0;
    }

    .gra-panel {
        border: 1px solid var(--gra-border);
        border-radius: 8px;
        background: #ffffff;
        box-shadow: 0 12px 30px rgba(15, 23, 42, 0.07);
    }

    .gra-panel + .gra-panel {
        margin-top: 28px;
    }

    .gra-panel-body {
        padding: 30px;
    }

    .gra-section-heading {
        display: flex;
        align-items: center;
        gap: 18px;
        margin-bottom: 26px;
    }

    .gra-icon-box {
        width: 56px;
        height: 56px;
        flex: 0 0 56px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 8px;
        background: var(--gra-green-soft);
        color: var(--gra-green);
        font-size: 28px;
    }

    .gra-section-heading h2 {
        margin: 0 0 4px;
        font-size: 20px;
        font-weight: 700;
    }

    .gra-section-heading p {
        margin: 0;
        color: var(--gra-muted);
        font-size: 14px;
    }

    .gra-filter-grid {
        display: grid;
        grid-template-columns: minmax(220px, 1fr) minmax(220px, 1fr) auto;
        gap: 24px;
        align-items: end;
    }

    .gra-field label {
        display: block;
        margin-bottom: 9px;
        color: #26323f;
        font-weight: 700;
        font-size: 13px;
    }

    .gra-input-wrap {
        position: relative;
    }

    .gra-input-wrap .form-control {
        min-height: 48px;
        padding-right: 44px;
        border-color: #d8dfdd;
        border-radius: 6px;
        color: #2b3440;
    }

    .gra-input-wrap i {
        position: absolute;
        right: 14px;
        top: 50%;
        transform: translateY(-50%);
        color: #5f6c78;
        font-size: 20px;
        pointer-events: none;
    }

    .gra-generate-btn {
        min-height: 48px;
        min-width: 190px;
        border: 0;
        border-radius: 7px;
        background: linear-gradient(180deg, #11703a, #075325);
        color: #ffffff;
        font-weight: 700;
        box-shadow: 0 10px 20px rgba(9, 89, 39, 0.2);
    }

    .gra-generate-btn:hover,
    .gra-generate-btn:focus {
        color: #ffffff;
        background: linear-gradient(180deg, #0f6235, #06451f);
    }

    .gra-calendar-art {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        min-height: 120px;
        color: rgba(13, 103, 51, 0.2);
        font-size: 98px;
    }

    .gra-alert {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 16px 20px;
        margin-bottom: 26px;
        border: 1px solid #dcecdf;
        border-radius: 7px;
        background: #edf8ee;
        color: #135b2c;
        font-size: 14px;
    }

    .gra-range-toast {
        position: fixed;
        top: 24px;
        right: 24px;
        z-index: 1080;
        display: grid;
        grid-template-columns: 46px minmax(0, 1fr) 32px;
        gap: 13px;
        align-items: center;
        width: min(430px, calc(100vw - 32px));
        padding: 16px 16px 18px;
        overflow: hidden;
        border: 1px solid #f3d59b;
        border-radius: 14px;
        background: rgba(255, 253, 247, 0.98);
        box-shadow: 0 20px 55px rgba(44, 35, 15, 0.2);
        backdrop-filter: blur(12px);
        animation: graToastEnter 0.3s cubic-bezier(0.2, 0.85, 0.35, 1.2) both;
    }

    .gra-range-toast.is-closing {
        animation: graToastLeave 0.22s ease-in both;
    }

    .gra-range-toast-icon {
        display: grid;
        width: 46px;
        height: 46px;
        place-items: center;
        border-radius: 12px;
        background: #fff1cc;
        color: #a45b05;
        font-size: 24px;
    }

    .gra-range-toast strong {
        display: block;
        margin-bottom: 3px;
        color: #322813;
        font-size: 15px;
        font-weight: 800;
    }

    .gra-range-toast p {
        margin: 0;
        color: #6e6044;
        font-size: 13px;
        line-height: 1.45;
    }

    .gra-range-toast-close {
        width: 32px;
        height: 32px;
        padding: 0;
        border: 0;
        border-radius: 9px;
        background: transparent;
        color: #756b58;
        font-size: 19px;
        transition: background 0.2s ease, color 0.2s ease;
    }

    .gra-range-toast-close:hover {
        background: #f6ead1;
        color: #3e3422;
    }

    .gra-range-toast-progress {
        position: absolute;
        right: 0;
        bottom: 0;
        left: 0;
        height: 3px;
        background: linear-gradient(90deg, #d99116, #f0b84b);
        transform-origin: left;
        animation: graToastProgress 8s linear both;
    }

    @keyframes graToastEnter {
        from { opacity: 0; transform: translate3d(24px, -8px, 0) scale(0.96); }
        to { opacity: 1; transform: translate3d(0, 0, 0) scale(1); }
    }

    @keyframes graToastLeave {
        to { opacity: 0; transform: translate3d(18px, 0, 0) scale(0.97); }
    }

    @keyframes graToastProgress {
        to { transform: scaleX(0); }
    }

    .gra-preview-empty {
        min-height: 395px;
        border: 1px solid var(--gra-border);
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        text-align: center;
        padding: 36px;
    }

    .gra-preview-empty i {
        display: block;
        margin-bottom: 20px;
        color: rgba(13, 103, 51, 0.42);
        font-size: 86px;
    }

    .gra-preview-empty h3 {
        margin: 0 0 10px;
        font-size: 19px;
        font-weight: 800;
    }

    .gra-preview-empty p {
        max-width: 450px;
        margin: 0 auto;
        color: var(--gra-muted);
        line-height: 1.7;
    }

    .gra-summary-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(180px, 1fr));
        gap: 18px;
        margin-bottom: 22px;
    }

    .gra-summary-tile {
        border: 1px solid var(--gra-border);
        border-radius: 8px;
        padding: 18px;
        background: #fbfdfc;
    }

    .gra-summary-tile span {
        display: block;
        margin-bottom: 8px;
        color: var(--gra-muted);
        font-size: 13px;
    }

    .gra-summary-tile strong {
        display: block;
        color: var(--gra-green-dark);
        font-size: 24px;
        font-weight: 800;
    }

    .gra-table-wrap {
        width: 100%;
        max-width: 100%;
        min-width: 0;
        border: 1px solid var(--gra-border);
        border-radius: 8px;
        overflow: hidden;
        scrollbar-width: thin;
        scrollbar-color: #9ab9a6 #eef5f0;
        -webkit-overflow-scrolling: touch;
    }

    .gra-table-wrap .dataTables_wrapper,
    .gra-table-wrap .dataTables_scroll,
    .gra-table-wrap .dataTables_scrollHead,
    .gra-table-wrap .dataTables_scrollBody {
        width: 100% !important;
        max-width: 100%;
        min-width: 0;
    }

    .gra-table-wrap .dataTables_scrollHeadInner {
        max-width: none;
    }

    .gra-table-wrap::-webkit-scrollbar {
        height: 10px;
    }

    .gra-table-wrap::-webkit-scrollbar-track {
        background: #eef5f0;
    }

    .gra-table-wrap::-webkit-scrollbar-thumb {
        border: 2px solid #eef5f0;
        border-radius: 999px;
        background: #9ab9a6;
    }

    .gra-table-wrap .dataTables_scrollBody {
        overflow-x: auto !important;
        scrollbar-width: thin;
        scrollbar-color: #9ab9a6 #eef5f0;
        -webkit-overflow-scrolling: touch;
    }

    .gra-table-wrap .dataTables_scrollBody::-webkit-scrollbar {
        height: 10px;
    }

    .gra-table-wrap .dataTables_scrollBody::-webkit-scrollbar-track {
        background: #eef5f0;
    }

    .gra-table-wrap .dataTables_scrollBody::-webkit-scrollbar-thumb {
        border: 2px solid #eef5f0;
        border-radius: 999px;
        background: #9ab9a6;
    }

    .gra-panel .dt-buttons {
        display: inline-flex;
        flex-wrap: wrap;
        gap: 8px;
        margin: 0 0 16px;
    }

    .gra-panel .dt-buttons .gra-export-button {
        display: inline-flex;
        align-items: center;
        gap: 7px;
        min-height: 38px;
        margin: 0;
        padding: 8px 14px;
        border: 1px solid #d9e6dd;
        border-radius: 9px;
        background: #ffffff;
        color: #285139;
        box-shadow: 0 3px 10px rgba(18, 76, 42, 0.07);
        font-size: 13px;
        font-weight: 700;
        line-height: 1;
        transition: transform 0.18s ease, border-color 0.18s ease, background 0.18s ease, box-shadow 0.18s ease;
    }

    .gra-panel .dt-buttons .gra-export-button:hover,
    .gra-panel .dt-buttons .gra-export-button:focus {
        border-color: #8fc3a1;
        background: #eff8f2;
        color: #06451f;
        box-shadow: 0 7px 18px rgba(18, 76, 42, 0.13);
        transform: translateY(-1px);
    }

    .gra-panel .dt-buttons .gra-export-button i {
        color: #0d7839;
        font-size: 16px;
        font-weight: 400;
    }

    .gra-table-wrap .table {
        width: 100% !important;
        min-width: 900px;
        margin-bottom: 0;
        table-layout: auto;
    }

    .gra-table-wrap thead th {
        background: #f4faf6;
        color: #26323f;
        font-size: 12px;
        text-transform: uppercase;
        white-space: nowrap;
    }

    .gra-table-wrap th,
    .gra-table-wrap td {
        min-width: 120px;
        padding: 13px 14px !important;
        vertical-align: top;
    }

    .gra-table-wrap tbody td {
        color: #364152;
        line-height: 1.45;
        white-space: normal;
        overflow-wrap: anywhere;
    }

    .gra-table-wrap .gra-name-column {
        min-width: 170px;
    }

    .gra-table-wrap .gra-name-preview {
        display: -webkit-box;
        overflow: hidden;
        line-height: 1.45;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
    }

    .gra-details-btn {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        border: 0;
        border-radius: 5px;
        padding: 6px 9px;
        background: transparent;
        color: var(--gra-green);
        font-size: 12px;
        font-weight: 700;
        white-space: nowrap;
    }

    .gra-details-btn:hover,
    .gra-details-btn:focus {
        background: var(--gra-green-soft);
        color: var(--gra-green-dark);
    }

    .gra-record-details {
        overflow: hidden;
        margin: 8px 10px 14px;
        border: 1px solid #cfe3d5;
        border-left: 4px solid var(--gra-green);
        border-radius: 8px;
        background: #ffffff;
        box-shadow: 0 8px 22px rgba(13, 103, 51, 0.08);
    }

    .gra-record-details-header {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 15px 20px;
        border-bottom: 1px solid #dcebe1;
        background: linear-gradient(90deg, #e9f6ed, #f8fcf9);
        color: var(--gra-green-dark);
    }

    .gra-record-details-header i {
        font-size: 22px;
    }

    .gra-record-details-header strong {
        display: block;
        font-size: 15px;
    }

    .gra-record-details-header span {
        display: block;
        margin-top: 2px;
        color: var(--gra-muted);
        font-size: 12px;
    }

    .gra-record-details-body {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 0;
        padding: 20px;
    }

    .gra-detail-section {
        padding: 0 20px;
        border-right: 1px solid #e3ece6;
    }

    .gra-detail-section:first-child {
        padding-left: 0;
    }

    .gra-detail-section:last-child {
        padding-right: 0;
        border-right: 0;
    }

    .gra-detail-section h4 {
        margin: 0 0 14px;
        color: var(--gra-green-dark);
        font-size: 12px;
        font-weight: 800;
        letter-spacing: .05em;
        text-transform: uppercase;
    }

    .gra-record-details-grid {
        display: grid;
        grid-template-columns: 1fr;
        gap: 14px;
    }

    .gra-detail-item span {
        display: block;
        margin-bottom: 5px;
        color: #435148;
        font-size: 12px;
        font-weight: 800;
    }

    .gra-detail-item strong {
        display: block;
        color: #273444;
        font-size: 13px;
        font-weight: 500;
        line-height: 1.55;
        overflow-wrap: anywhere;
    }

    .gra-details-modal .modal-content {
        overflow: hidden;
        border: 0;
        border-radius: 16px;
        box-shadow: 0 24px 70px rgba(6, 69, 31, 0.2);
    }

    .gra-details-modal .modal-header {
        border-bottom: 1px solid #dcebe1;
        background: linear-gradient(112deg, #043c1b, #0d7839);
        color: #ffffff;
    }

    .gra-details-modal .modal-title {
        display: flex;
        align-items: center;
        gap: 9px;
        font-size: 17px;
        font-weight: 800;
    }

    .gra-details-modal .btn-close {
        filter: invert(1) grayscale(1) brightness(2);
    }

    .gra-details-modal .modal-body {
        padding: 18px;
        background: #f6faf8;
    }

    .gra-details-modal .gra-record-details {
        margin: 0;
    }

    .gra-detail-item-wide {
        grid-column: auto;
    }

    .gra-table-wrap tbody tr:nth-child(even) td {
        background: #fbfdfc;
    }

    .gra-table-wrap tbody tr:hover td {
        background: #f0f8f3;
    }

    .gra-filter-bar {
        display: flex;
        align-items: end;
        gap: 18px;
        margin: 0 0 22px;
        padding: 18px 20px;
        border: 1px solid #d8e7dc;
        border-radius: 8px;
        background: #f7fbf8;
    }

    .gra-filter-bar-heading {
        min-width: 210px;
        margin-right: auto;
    }

    .gra-filter-bar-heading strong {
        display: flex;
        align-items: center;
        gap: 7px;
        color: var(--gra-green-dark);
        font-size: 14px;
    }

    .gra-filter-bar-heading span,
    .gra-filter-field small {
        display: block;
        margin-top: 4px;
        color: var(--gra-muted);
        font-size: 11px;
    }

    .gra-filter-field {
        min-width: 190px;
    }

    .gra-filter-field label {
        display: block;
        margin-bottom: 6px;
        color: #34433a;
        font-size: 12px;
        font-weight: 800;
    }

    .gra-filter-reset {
        min-height: 31px;
        white-space: nowrap;
    }

    .gra-payment-status {
        display: inline-block;
        border-radius: 999px;
        padding: 5px 10px;
        font-size: 12px;
        font-weight: 700;
        white-space: nowrap;
    }

    .gra-payment-status-paid {
        background: #e4f6e9;
        color: #08652d;
    }

    .gra-payment-status-unpaid {
        background: #fff0f0;
        color: #b42318;
    }

    .gra-footer-note {
        display: flex;
        align-items: center;
        gap: 13px;
        margin-top: 28px;
        padding: 16px 24px;
        border: 1px solid #dcecdf;
        border-radius: 8px;
        background: #edf8ee;
        color: #2c3f36;
        font-size: 13px;
    }

    @media (max-width: 991.98px) {
        .gra-report-page {
            padding-right: 16px;
            padding-left: 16px;
        }

        .gra-hero {
            min-height: 148px;
            padding: 26px 28px;
        }

        .gra-filter-grid {
            grid-template-columns: 1fr;
            gap: 18px;
        }

        .gra-generate-btn {
            width: 100%;
        }

        .gra-calendar-art {
            display: none;
        }

        .gra-filter-bar {
            align-items: stretch;
            flex-direction: column;
        }

        .gra-filter-field,
        .gra-filter-bar-heading {
            width: 100%;
        }

        .gra-filter-reset {
            align-self: flex-start;
        }

        .gra-record-details-grid {
            grid-template-columns: 1fr;
        }

        .gra-record-details-body {
            grid-template-columns: 1fr;
            gap: 20px;
        }

        .gra-detail-section,
        .gra-detail-section:first-child,
        .gra-detail-section:last-child {
            padding: 0 0 20px;
            border-right: 0;
            border-bottom: 1px solid #e3ece6;
        }

        .gra-detail-section:last-child {
            padding-bottom: 0;
            border-bottom: 0;
        }
    }

    @media (max-width: 767.98px) {
        .gra-shell,
        .gra-panel + .gra-panel,
        .gra-footer-note {
            margin-top: 20px;
        }

        .gra-panel-body {
            padding: 24px;
        }

        .gra-hero-buildings {
            right: 14px;
            opacity: 0.16;
            transform: scale(0.82);
            transform-origin: right bottom;
        }

        .gra-preview-empty {
            min-height: 310px;
            padding: 28px 20px;
        }

        .gra-preview-empty i {
            font-size: 70px;
        }

        .gra-panel .dt-buttons {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            width: 100%;
        }

        .gra-panel .dt-buttons .gra-export-button {
            justify-content: center;
            width: 100%;
            min-height: 43px;
        }

        .gra-table-wrap .dataTables_length,
        .gra-table-wrap .dataTables_filter,
        .gra-table-wrap .dataTables_info,
        .gra-table-wrap .dataTables_paginate {
            float: none !important;
            width: 100%;
            text-align: left !important;
        }

        .gra-table-wrap .dataTables_filter label,
        .gra-table-wrap .dataTables_filter input {
            width: 100%;
        }

        .gra-table-wrap .dataTables_filter input {
            min-height: 42px;
            margin: 6px 0 12px !important;
        }

        .gra-table-wrap .dataTables_paginate .pagination {
            flex-wrap: wrap;
            justify-content: center;
            gap: 3px;
            margin-top: 12px !important;
        }

        .gra-table-wrap .table {
            min-width: 780px;
        }

        .gra-table-wrap table.dataTable thead th:nth-child(8),
        .gra-table-wrap table.dataTable tbody td:nth-child(8) {
            position: sticky;
            right: 0;
            z-index: 2;
            min-width: 108px;
            background: #ffffff;
            box-shadow: -8px 0 14px rgba(31, 41, 51, 0.08);
        }

        .gra-table-wrap table.dataTable thead th:nth-child(8) {
            z-index: 4;
            background: #eaf6ee;
        }

        .gra-table-wrap tbody tr:nth-child(even) td:nth-child(8) {
            background: #fbfdfc;
        }

        .gra-details-btn {
            justify-content: center;
            width: 100%;
            min-height: 40px;
            padding: 8px;
            background: var(--gra-green-soft);
        }

        .gra-footer-note {
            align-items: flex-start;
            padding: 15px 17px;
        }
    }

    @media (max-width: 575.98px) {
        .gra-range-toast {
            top: 16px;
            right: 16px;
        }

        .gra-hero {
            min-height: 0;
            padding: 22px 18px 28px;
            border-radius: 0 0 12px 12px;
        }

        .gra-hero-content {
            align-items: flex-start;
            flex-direction: column;
            gap: 14px;
        }

        .gra-logo {
            width: 66px;
            height: 66px;
        }

        .gra-hero h1 {
            font-size: clamp(26px, 9vw, 30px);
            line-height: 1.15;
        }

        .gra-hero p {
            font-size: 14px;
            line-height: 1.55;
        }

        .gra-hero-buildings {
            display: none;
        }

        .gra-report-page {
            padding-right: 10px;
            padding-bottom: 22px;
            padding-left: 10px;
        }

        .gra-panel {
            border-radius: 10px;
        }

        .gra-panel-body {
            padding: 20px 16px;
        }

        .gra-section-heading {
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 20px;
        }

        .gra-icon-box {
            width: 44px;
            height: 44px;
            flex-basis: 44px;
            font-size: 22px;
        }

        .gra-section-heading h2 {
            font-size: 18px;
        }

        .gra-input-wrap .form-control,
        .gra-filter-field .form-select {
            min-height: 48px;
            font-size: 16px;
        }

        .gra-alert {
            align-items: flex-start;
            padding: 14px 15px;
            line-height: 1.55;
        }

        .gra-filter-bar {
            gap: 14px;
            padding: 16px;
        }

        .gra-filter-reset {
            width: 100%;
            min-height: 44px;
        }

        .gra-summary-grid {
            grid-template-columns: 1fr;
            gap: 12px;
        }

        .gra-summary-tile {
            padding: 16px;
        }

        .gra-summary-tile strong {
            font-size: 21px;
            overflow-wrap: anywhere;
        }

        .gra-record-details {
            margin: 8px 4px 12px;
        }

        .gra-record-details-header,
        .gra-record-details-body {
            padding: 15px;
        }

        .gra-details-modal .modal-body {
            padding: 12px;
        }

        .gra-details-modal .modal-header {
            padding: 15px 16px;
        }

        .gra-range-toast {
            width: calc(100vw - 24px);
            right: 12px;
            grid-template-columns: 42px minmax(0, 1fr) 30px;
            padding: 14px 12px 16px;
        }

        .flatpickr-calendar {
            max-width: calc(100vw - 20px);
        }

        .gra-record-details-grid {
            grid-template-columns: 1fr;
        }

        .gra-detail-item-wide {
            grid-column: auto;
        }
    }
</style>

<div class="main-content app-content">
    <div class="container-fluid gra-report-page pb-5">
        <div class="gra-hero">
            <div class="gra-hero-content">
                <img class="gra-logo" src="${pageContext.request.contextPath}/assets/images/NewLogo.png" alt="Lands Commission">
                <div>
                    <h1>Stamp Duty Report</h1>
                    <p>Generate and view Stamp Duty reports for a selected period.</p>
                </div>
            </div>
            <div class="gra-hero-buildings" aria-hidden="true">
                <span class="gra-building"></span>
                <span class="gra-building"></span>
                <span class="gra-building"></span>
            </div>
        </div>

        <div class="gra-shell">
            <div class="gra-panel">
                <div class="gra-panel-body">
                    <div class="row align-items-center">
                        <div class="col-lg-9">
                            <div class="gra-section-heading">
                                <span class="gra-icon-box"><i class="ri-calendar-line"></i></span>
                                <div>
                                    <h2>Select Date Range</h2>
                                    <p>Choose a start and end date to generate your Stamp Duty report.</p>
                                </div>
                            </div>

                            <form id="frmGraReportFilter">
                                <div class="gra-filter-grid">
                                    <div class="gra-field">
                                        <label for="gra_date_from">Start Date</label>
                                        <div class="gra-input-wrap">
                                            <input type="text" class="form-control" id="gra_date_from" name="date_from" placeholder="Select start date" autocomplete="off" required>
                                            <i class="ri-calendar-line"></i>
                                        </div>
                                    </div>
                                    <div class="gra-field">
                                        <label for="gra_date_to">End Date</label>
                                        <div class="gra-input-wrap">
                                            <input type="text" class="form-control" id="gra_date_to" name="date_to" placeholder="Select end date" autocomplete="off" required>
                                            <i class="ri-calendar-line"></i>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn gra-generate-btn" id="btnGenerateGraReport">
                                        <i class="ri-file-chart-line me-2"></i>Generate Report
                                    </button>
                                </div>
                            </form>
                        </div>
                        <div class="col-lg-3 d-none d-lg-block">
                            <div class="gra-calendar-art" aria-hidden="true">
                                <i class="ri-calendar-check-line"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="gra-panel">
                <div class="gra-panel-body">
                    <div class="gra-section-heading">
                        <span class="gra-icon-box"><i class="ri-file-chart-line"></i></span>
                        <div>
                            <h2>Report Preview</h2>
                            <p>Preview of the GRA report for the selected period. Click Generate Report to refresh the data.</p>
                        </div>
                    </div>

                    <div class="gra-alert" id="graReportNotice">
                        <i class="ri-calendar-event-line fs-5"></i>
                        <span>No report generated yet. Please select a date range and click Generate Report to view the report preview.</span>
                    </div>


                    <div class="gra-filter-bar" aria-label="Report result filters">
                        <div class="gra-filter-bar-heading">
                            <strong><i class="ri-filter-3-line"></i> Filter report results</strong>
                            <span>Narrow the table and summary totals using either or both filters.</span>
                        </div>
                        <div class="gra-filter-field">
                            <label for="report_count_sel_change_region_compliance">Region</label>
                            <select id="report_count_sel_change_region_compliance" class="form-select form-select-sm">
                                <option selected value="0">All Regions</option>
                                <c:forEach items="${officeregionlist}" var="officeregion">
                                    <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                                </c:forEach>
                            </select>
                            <small>Show records from a specific region.</small>
                        </div>
                        <div class="gra-filter-field">
                            <label for="graPaymentStatusFilter">Payment Status</label>
                            <select class="form-select form-select-sm" id="graPaymentStatusFilter">
                                <option value="">All Payment Statuses</option>
                                <option value="Paid">Paid</option>
                                <option value="Not Paid">Not Paid</option>
                            </select>
                            <small>Show paid or unpaid records.</small>
                        </div>
                        <button type="button" class="btn btn-light btn-sm gra-filter-reset" id="btnResetGraFilters">
                            <i class="ri-refresh-line me-1"></i>Reset filters
                        </button>
                    </div>






                    <div id="graReportEmptyState" class="gra-preview-empty">
                        <div>
                            <i class="ri-file-search-line"></i>
                            <h3>Your report preview will appear here</h3>
                            <p>Select a date range and generate the report to see the summary and details of your GRA report.</p>
                        </div>
                    </div>

                    <div id="graReportResults" class="d-none">
                        <div class="gra-summary-grid">
                            <div class="gra-summary-tile">
                                <span>Total Stamp Duty</span>
                                <strong id="graTotalAmount">GHS 0.00</strong>
                            </div>
                            <div class="gra-summary-tile">
                                <span>Total Record Count</span>
                                <strong id="graTotalCount">0</strong>
                            </div>
                        </div>

                        <div class="gra-table-wrap table-responsive">
                            <table class="table table-hover align-middle" id="tblGraReportPreview">
                                <thead>
                                    <tr>
                                        <th>Job Number</th>
                                        <th>Grantee Name</th>
                                        <th>Grantor Name</th>
                                        <th>Location Of Property</th>
                                        <th>Stamp Duty Payable</th>
                                        <th>Payment Date</th>
                                        <th>Payment Status</th>
                                        <th>Details</th>
                                        <th>Grantee Address</th>
                                        <th>Grantee Phone Number</th>
                                        <th>Grantee Email</th>
                                        <th>Grantor Address</th>
                                        <th>Land Size</th>
                                        <th>Consideration Fee</th>
                                        <th>Assessed Value</th>
                                        <th>Date of Instrument</th>
                                        <th>Year</th>
                                        <th>Interest</th>
                                        <th>Instrument</th>
                                        <th>Region Code</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>

<div class="modal fade gra-details-modal" id="graRecordDetailsModal" tabindex="-1"
    aria-labelledby="graRecordDetailsModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable modal-fullscreen-sm-down">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="graRecordDetailsModalTitle">
                    <i class="ri-file-list-3-line"></i> Record Information
                </h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="graRecordDetailsModalBody"></div>
        </div>
    </div>
</div>

<script>
    $(function () {
        $(window).on("beforeunload.graReport", function () {
            $("body").removeClass("gra-fullscreen-report");
        });

        var graTable = null;
        var graRowDetails = {};
        var graWarningTimer = null;
        var $activeMobileDetailsButton = null;

        if (window.flatpickr) {
            var dateFromPicker;
            var dateToPicker;

            dateFromPicker = flatpickr("#gra_date_from", {
                dateFormat: "Y-m-d",
                altInput: true,
                altFormat: "j F Y",
                allowInput: true,
                disableMobile: true,
                onChange: function (selectedDates, dateString) {
                    dateToPicker.set("minDate", dateString || null);
                    var currentEndDate = $("#gra_date_to").val();

                    if (dateString && currentEndDate && currentEndDate < dateString) {
                        dateToPicker.clear();
                        showNotice("End Date must be the same as or later than Start Date.", true);
                    } else if (dateString && currentEndDate && exceedsThreeMonths(dateString, currentEndDate)) {
                        showThreeMonthWarning();
                    }
                }
            });

            dateToPicker = flatpickr("#gra_date_to", {
                dateFormat: "Y-m-d",
                altInput: true,
                altFormat: "j F Y",
                allowInput: true,
                disableMobile: true,
                onChange: function (selectedDates, dateString) {
                    dateFromPicker.set("maxDate", dateString || null);
                    var currentStartDate = $("#gra_date_from").val();

                    if (dateString && currentStartDate && currentStartDate > dateString) {
                        dateFromPicker.clear();
                        showNotice("Start Date must be the same as or earlier than End Date.", true);
                    } else if (dateString && currentStartDate && exceedsThreeMonths(currentStartDate, dateString)) {
                        showThreeMonthWarning();
                    }
                }
            });
        }

        function maximumThreeMonthDate(dateString) {
            var parts = dateString.split("-").map(Number);
            var targetYear = parts[0];
            var targetMonth = parts[1] - 1 + 3;
            targetYear += Math.floor(targetMonth / 12);
            targetMonth %= 12;

            var lastDayOfTargetMonth = new Date(targetYear, targetMonth + 1, 0).getDate();
            var targetDay = Math.min(parts[2], lastDayOfTargetMonth);
            var month = String(targetMonth + 1).padStart(2, "0");
            var day = String(targetDay).padStart(2, "0");

            return targetYear + "-" + month + "-" + day;
        }

        function exceedsThreeMonths(dateFrom, dateTo) {
            return dateTo > maximumThreeMonthDate(dateFrom);
        }

        function showThreeMonthWarning() {
            var message = "You can only generate a report for a date range of up to 3 months.";
            showNotice(message, true);

            clearTimeout(graWarningTimer);
            $(".gra-range-toast").remove();

            var $toast = $(
                '<div class="gra-range-toast" role="alert" aria-live="assertive">' +
                    '<div class="gra-range-toast-icon"><i class="ri-calendar-event-line"></i></div>' +
                    '<div><strong>Date range too long</strong><p>' + message + '</p></div>' +
                    '<button type="button" class="gra-range-toast-close" aria-label="Close warning">' +
                        '<i class="ri-close-line"></i>' +
                    '</button>' +
                    '<span class="gra-range-toast-progress"></span>' +
                '</div>'
            ).appendTo("body");

            function closeToast() {
                clearTimeout(graWarningTimer);
                $toast.addClass("is-closing");
                setTimeout(function () { $toast.remove(); }, 220);
            }

            $toast.find(".gra-range-toast-close").on("click", closeToast);
            graWarningTimer = setTimeout(closeToast, 8000);
        }

        function isValidReportDate(value) {
            if (!/^\d{4}-\d{2}-\d{2}$/.test(value)) {
                return false;
            }

            var parts = value.split("-").map(Number);
            var date = new Date(parts[0], parts[1] - 1, parts[2]);
            return date.getFullYear() === parts[0] &&
                date.getMonth() === parts[1] - 1 &&
                date.getDate() === parts[2];
        }

        function formatCurrency(value) {
            var amount = Number(value || 0);
            return new Intl.NumberFormat("en-US", {
                style: "currency",
                currency: "GHS"
            }).format(amount);
        }

        function displayValue(value) {
            if (value === null || value === undefined || value === "" || value === "0") {
                return "-";
            }

            return $("<div>").text(value).html();
        }

        function formatReportDate(value) {
            if (!value) {
                return "-";
            }

            var date = new Date(value);
            if (Number.isNaN(date.getTime())) {
                return displayValue(value);
            }

            return date.toLocaleDateString("en-GB", {
                year: "numeric",
                month: "short",
                day: "2-digit"
            });
        }

        function formatReportingPeriodDate(value) {
            if (!isValidReportDate(value)) {
                return value || "Not selected";
            }

            var parts = value.split("-").map(Number);
            var day = parts[2];
            var remainder100 = day % 100;
            var suffix = "th";

            if (remainder100 < 11 || remainder100 > 13) {
                if (day % 10 === 1) suffix = "st";
                else if (day % 10 === 2) suffix = "nd";
                else if (day % 10 === 3) suffix = "rd";
            }

            var monthName = new Intl.DateTimeFormat("en-GB", { month: "long" })
                .format(new Date(parts[0], parts[1] - 1, 1));

            return day + suffix + " " + monthName + ", " + parts[0];
        }

        function namePreview(value) {
            var safeValue = displayValue(value);
            return '<span class="gra-name-preview" title="' + safeValue + '">' + safeValue + '</span>';
        }

        function paymentStatus(value) {
            var isPaid = String(value) === "1";
            var label = isPaid ? "Paid" : "Not Paid";
            var statusClass = isPaid ? "gra-payment-status-paid" : "gra-payment-status-unpaid";
            return '<span class="gra-payment-status ' + statusClass + '">' + label + '</span>';
        }

        function normaliseRegionCode(value) {
            if (value === null || value === undefined || value === "") {
                return "";
            }

            var numericCode = Number(value);
            return Number.isNaN(numericCode) ? String(value).trim() : String(numericCode);
        }

        function applyRegionFilter(table) {
            var selectedRegion = normaliseRegionCode($("#report_count_sel_change_region_compliance").val());
            var regionSearch = selectedRegion && selectedRegion !== "0"
                ? "^" + $.fn.dataTable.util.escapeRegex(selectedRegion) + "$"
                : "";

            table.column(19).search(regionSearch, true, false);
        }

        function updateFilteredSummary(table) {
            var filteredRows = table.rows({ search: "applied" }).data().toArray();
            var filteredStampDuty = filteredRows.reduce(function (total, row) {
                var numericValue = String(row[4] || "").replace(/[^0-9.-]/g, "");
                return total + (Number(numericValue) || 0);
            }, 0);

            $("#graTotalAmount").text(formatCurrency(filteredStampDuty));
            $("#graTotalCount").text(new Intl.NumberFormat().format(filteredRows.length));
        }

        function exportTitle() {
            return "Stamp Duty Report";
        }

        function exportDescription() {
            var dateFrom = $("#gra_date_from").val() || "Not selected";
            var dateTo = $("#gra_date_to").val() || "Not selected";
            var region = $("#report_count_sel_change_region_compliance option:selected").text() || "All Regions";
            var paymentStatus = $("#graPaymentStatusFilter option:selected").text() || "All Payment Statuses";

            return "Reporting period: " + formatReportingPeriodDate(dateFrom) +
                " to " + formatReportingPeriodDate(dateTo) +
                " | Region: " + region.trim() +
                " | Payment Status: " + paymentStatus.trim();
        }

        function exportFilename() {
            var dateFrom = $("#gra_date_from").val() || "start";
            var dateTo = $("#gra_date_to").val() || "end";
            return "Stamp_Duty_Report_" + dateFrom + "_to_" + dateTo;
        }

        function buildRecordDetails(item) {
            var sections = [
                {
                    title: "Party & Contact",
                    details: [
                        ["Grantee Address", displayValue(item.grantee_address)],
                        ["Grantee Phone Number", displayValue(item.grantee_phone_number)],
                        ["Grantee Email", displayValue(item.grantee_email)],
                        ["Grantor Address", displayValue(item.grantors_address)]
                    ]
                },
                {
                    title: "Property & Instrument",
                    details: [
                        ["Land Size", displayValue(item.land_size)],
                        ["Date of Instrument", formatReportDate(item.date_of_document)],
                        ["Year", displayValue(item.year_created)],
                        ["Interest", displayValue(item.type_of_interest)],
                        ["Instrument", displayValue(item.nature_of_instrument)]
                    ]
                },
                {
                    title: "Financial Details",
                    details: [
                        ["Consideration Fee", formatCurrency(item.consideration_fee)],
                        ["Assessed Value", formatCurrency(item.assessed_value)],
                        ["Stamp Duty Payable", formatCurrency(item.stamp_duty_payable)],
                        ["Payment Status", String(item.payment_status) === "1" ? "Paid" : "Not Paid"]
                    ]
                }
            ];

            return '<div class="gra-record-details">' +
                '<div class="gra-record-details-header"><i class="ri-file-list-3-line"></i><div>' +
                '<strong>Additional Record Details</strong><span>Expanded information for ' + displayValue(item.job_number) + '</span></div></div>' +
                '<div class="gra-record-details-body">' +
                sections.map(function (section) {
                    return '<section class="gra-detail-section"><h4>' + section.title + '</h4><div class="gra-record-details-grid">' +
                        section.details.map(function (detail) {
                            return '<div class="gra-detail-item"><span>' + detail[0] + '</span><strong>' + detail[1] + '</strong></div>';
                        }).join("") + '</div></section>';
                }).join("") +
                '</div></div>';
        }

        function normaliseResponse(response) {
            var payload = typeof response === "string" ? JSON.parse(response) : response;
            return {
                summary: payload.summary || {},
                data: payload.data || payload.details || payload.result || [],
                count: payload.count,
                status: payload.status,
                message: payload.message
            };
        }

        function ensureDataTable() {
            if (graTable) {
                return graTable;
            }

            var exportColumns = [0, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];
            var exportOptions = { columns: exportColumns };

            graTable = $("#tblGraReportPreview").DataTable({
                responsive: false,
                scrollX: true,
                autoWidth: false,
                pageLength: 10,
                lengthMenu: [[10, 25, 50, 100], [10, 25, 50, 100]],
                order: [[5, "desc"]],
                dom: "Blfrtip",
                buttons: [
                    {
                        extend: "copy",
                        text: '<i class="ri-file-copy-line"></i><span>Copy</span>',
                        className: "gra-export-button",
                        title: exportTitle,
                        messageTop: exportDescription,
                        exportOptions: exportOptions
                    },
                    {
                        extend: "excel",
                        text: '<i class="ri-file-excel-2-line"></i><span>Excel</span>',
                        className: "gra-export-button",
                        title: exportTitle,
                        messageTop: exportDescription,
                        filename: exportFilename,
                        exportOptions: exportOptions
                    },
                    {
                        extend: "pdf",
                        text: '<i class="ri-file-pdf-2-line"></i><span>PDF</span>',
                        className: "gra-export-button",
                        title: exportTitle,
                        messageTop: exportDescription,
                        filename: exportFilename,
                        orientation: "landscape",
                        pageSize: "A1",
                        exportOptions: exportOptions,
                        customize: function (doc) {
                            doc.pageOrientation = "landscape";
                            doc.pageSize = "A1";
                            doc.pageMargins = [18, 24, 18, 24];
                            doc.defaultStyle.fontSize = 6;
                            doc.styles.tableHeader.fontSize = 7;
                            doc.info = doc.info || {};
                            doc.info.title = exportTitle();
                            doc.info.subject = exportDescription();

                            var tableNode = doc.content.find(function (content) {
                                return content.table;
                            });

                            if (tableNode && tableNode.table.body.length) {
                                tableNode.table.widths = tableNode.table.body[0].map(function () {
                                    return "*";
                                });
                                tableNode.layout = {
                                    hLineWidth: function () { return 0.4; },
                                    vLineWidth: function () { return 0.4; },
                                    hLineColor: function () { return "#d6e2da"; },
                                    vLineColor: function () { return "#d6e2da"; },
                                    paddingLeft: function () { return 3; },
                                    paddingRight: function () { return 3; },
                                    paddingTop: function () { return 3; },
                                    paddingBottom: function () { return 3; }
                                };
                            }
                        }
                    },
                    {
                        extend: "print",
                        text: '<i class="ri-printer-line"></i><span>Print</span>',
                        className: "gra-export-button",
                        title: exportTitle,
                        messageTop: exportDescription,
                        exportOptions: exportOptions,
                        customize: function (printWindow) {
                            var printStyles =
                                '<style>' +
                                '@page { size: A4 landscape; margin: 10mm; }' +
                                'body { margin: 0; color: #1f2933; font-family: Arial, sans-serif; }' +
                                'h1 { margin: 0 0 6px; color: #06451f; font-size: 18px; }' +
                                '.dt-print-message { margin-bottom: 14px; color: #526057; font-size: 9px; }' +
                                '.gra-print-record { break-inside: avoid; page-break-inside: avoid; margin: 0 0 12px;' +
                                'border: 1px solid #bed5c5; border-left: 4px solid #0d6733; border-radius: 5px; }' +
                                '.gra-print-record-title { padding: 7px 10px; background: #eaf6ee;' +
                                'color: #06451f; font-size: 10px; font-weight: 700; }' +
                                '.gra-print-grid { display: grid; grid-template-columns: repeat(3, 1fr); }' +
                                '.gra-print-field { min-height: 34px; padding: 6px 9px; border-top: 1px solid #e1ebe4;' +
                                'border-right: 1px solid #e1ebe4; overflow-wrap: anywhere; }' +
                                '.gra-print-label { display: block; margin-bottom: 3px; color: #435148;' +
                                'font-size: 7px; font-weight: 700; text-transform: uppercase; }' +
                                '.gra-print-value { color: #1f2933; font-size: 8px; line-height: 1.3; }' +
                                '</style>';

                            $(printWindow.document.head).append(printStyles);
                            var $printTable = $(printWindow.document.body).find('table');
                            var headings = $printTable.find('thead th').map(function () {
                                return $(this).text().trim();
                            }).get();
                            var $records = $('<div class="gra-print-records"></div>');

                            $printTable.find('tbody tr').each(function (rowIndex) {
                                var values = $(this).find('td').map(function () {
                                    return $(this).text().trim() || '-';
                                }).get();
                                var jobNumber = values[0] || ('Record ' + (rowIndex + 1));
                                var $record = $('<section class="gra-print-record"></section>');
                                var $grid = $('<div class="gra-print-grid"></div>');

                                $record.append($('<div class="gra-print-record-title"></div>').text('Job Number: ' + jobNumber));
                                headings.forEach(function (heading, columnIndex) {
                                    var $field = $('<div class="gra-print-field"></div>');
                                    $field.append($('<span class="gra-print-label"></span>').text(heading));
                                    $field.append($('<span class="gra-print-value"></span>').text(values[columnIndex] || '-'));
                                    $grid.append($field);
                                });
                                $record.append($grid);
                                $records.append($record);
                            });

                            $printTable.replaceWith($records);
                        }
                    }
                ],
                columnDefs: [
                    { targets: [1, 2], className: "gra-name-column" },
                    { targets: 7, orderable: false, searchable: false, width: "90px" },
                    { targets: [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], visible: false }
                ]
            });

            graTable.on("draw", function () {
                updateFilteredSummary(graTable);
            });

            return graTable;
        }

        function showNotice(message, isError) {
            $("#graReportNotice")
                .toggleClass("border-danger text-danger", !!isError)
                .toggleClass("gra-alert", true)
                .find("span")
                .text(message);
        }

        $("#frmGraReportFilter").on("submit", function (event) {
            event.preventDefault();

            var dateFrom = $("#gra_date_from").val();
            var dateTo = $("#gra_date_to").val();
            var $button = $("#btnGenerateGraReport");

            if (!dateFrom || !dateTo) {
                showNotice("Please select both start and end dates before generating the report.", true);
                return;
            }

            if (!isValidReportDate(dateFrom) || !isValidReportDate(dateTo)) {
                showNotice("Please enter valid dates in YYYY-MM-DD format.", true);
                return;
            }

            if (dateFrom > dateTo) {
                showNotice("Start Date cannot be later than End Date. Please correct the date range.", true);
                return;
            }

            if (exceedsThreeMonths(dateFrom, dateTo)) {
                showNotice("The selected date range cannot be more than 3 months. Please choose a shorter date range.", true);
                return;
            }

            $.ajax({
                type: "POST",
                url: "reports_api",
                data: {
                    request_type: "get_stampduty_gra_results",
                    date_from: dateFrom,
                    date_to: dateTo
                },
                cache: false,
                beforeSend: function () {
                    $button.prop("disabled", true).html('<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Generating...');
                    showNotice("Generating report preview for the selected period...", false);
                },
                success: function (response) {
                    try {
                        var report = normaliseResponse(response);

                        console.log("Report data:", report);
                        var rows = Array.isArray(report.data) ? report.data : [];
                        var table = ensureDataTable();
                        var totalStampDuty = rows.reduce(function (total, item) {
                            return total + Number(item.stamp_duty_payable || 0);
                        }, 0);

                        table.clear();
                        graRowDetails = {};

                        $("#graTotalAmount").text(formatCurrency(report.summary.total_stamp_duty || report.summary.total_amount || report.summary.totalAmount || totalStampDuty));
                        $("#graTotalCount").text(new Intl.NumberFormat().format(report.summary.total_count || report.summary.totalCount || report.count || rows.length));

                        rows.forEach(function (item, index) {
                            var detailKey = "gra-detail-" + index;
                            graRowDetails[detailKey] = buildRecordDetails(item);
                            table.row.add([
                                displayValue(item.job_number),
                                namePreview(item.grantee),
                                namePreview(item.grantors_name),
                                displayValue(item.locality),
                                formatCurrency(item.stamp_duty_payable),
                                formatReportDate(item.created_date),
                                paymentStatus(item.payment_status),
                                '<button type="button" class="gra-details-btn" data-detail-key="' + detailKey + '" aria-expanded="false"><i class="ri-add-circle-line"></i><span>More Details</span></button>',
                                displayValue(item.grantee_address),
                                displayValue(item.grantee_phone_number),
                                displayValue(item.grantee_email),
                                displayValue(item.grantors_address),
                                displayValue(item.land_size),
                                formatCurrency(item.consideration_fee),
                                formatCurrency(item.assessed_value),
                                formatReportDate(item.date_of_document),
                                displayValue(item.year_created),
                                displayValue(item.type_of_interest),
                                displayValue(item.nature_of_instrument),
                                normaliseRegionCode(item.region_code)
                            ]);
                        });

                        applyRegionFilter(table);
                        table.draw();
                        $("#graReportEmptyState").addClass("d-none");
                        $("#graReportResults").removeClass("d-none");
                        table.columns.adjust();
                        showNotice((report.message || "Report generated successfully") + " for " + dateFrom + " to " + dateTo + ".", false);
                    } catch (error) {
                        console.log(error);
                        showNotice("Something went wrong while reading the report data. Please try again.", true);
                    }
                },
                error: function () {
                    showNotice("Unable to generate the report at this time. Please try again.", true);
                },
                complete: function () {
                    $button.prop("disabled", false).html('<i class="ri-file-chart-line me-2"></i>Generate Report');
                }
            });
        });

        $("#graPaymentStatusFilter").on("change", function () {
            var selectedStatus = $(this).val();
            var table = ensureDataTable();
            table.column(6).search(selectedStatus ? "^" + $.fn.dataTable.util.escapeRegex(selectedStatus) + "$" : "", true, false).draw();
        });

        $("#report_count_sel_change_region_compliance").on("change", function () {
            var table = ensureDataTable();
            applyRegionFilter(table);
            table.draw();
        });

        $("#btnResetGraFilters").on("click", function () {
            var table = ensureDataTable();
            $("#report_count_sel_change_region_compliance").val("0");
            $("#graPaymentStatusFilter").val("");
            table.column(6).search("");
            table.column(19).search("");
            table.draw();
        });

        $("#graRecordDetailsModal").on("hidden.bs.modal", function () {
            if ($activeMobileDetailsButton) {
                $activeMobileDetailsButton.attr("aria-expanded", "false")
                    .find("span").text("More Details");
                $activeMobileDetailsButton.find("i")
                    .removeClass("ri-subtract-line")
                    .addClass("ri-add-circle-line");
                $activeMobileDetailsButton = null;
            }
            $("#graRecordDetailsModalBody").empty();
        });

        $("#tblGraReportPreview tbody").on("click", ".gra-details-btn", function () {
            var $button = $(this);
            var detailContent = graRowDetails[$button.data("detail-key")];

            if (window.matchMedia("(max-width: 767.98px)").matches) {
                $activeMobileDetailsButton = $button;
                $("#graRecordDetailsModalBody").html(detailContent);
                $button.attr("aria-expanded", "true")
                    .find("span").text("Close");
                $button.find("i")
                    .removeClass("ri-add-circle-line")
                    .addClass("ri-subtract-line");
                bootstrap.Modal.getOrCreateInstance(document.getElementById("graRecordDetailsModal")).show();
                return;
            }

            var row = graTable.row($button.closest("tr"));
            var isOpen = row.child.isShown();

            if (isOpen) {
                row.child.hide();
            } else {
                row.child(detailContent).show();
            }

            $button.attr("aria-expanded", !isOpen)
                .find("i").toggleClass("ri-add-circle-line", isOpen).toggleClass("ri-subtract-line", !isOpen);
            $button.find("span").text(isOpen ? "More Details" : "Close");
        });
    });
</script>
