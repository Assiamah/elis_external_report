<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% response.setStatus(404); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page Not Found | GRA Report</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/NewLogo.jpg" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.css" rel="stylesheet">
    <style>
        :root {
            --gra-green: #0d6733;
            --gra-green-dark: #043c1b;
            --gra-text: #1f2933;
            --gra-muted: #687385;
        }

        * { box-sizing: border-box; }

        body {
            min-height: 100vh;
            min-height: 100dvh;
            margin: 0;
            overflow-x: hidden;
            color: var(--gra-text);
            background:
                radial-gradient(circle at 8% 90%, rgba(13, 120, 57, 0.1), transparent 30%),
                #f6faf8;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        .gra-error-page {
            display: grid;
            min-height: 100vh;
            min-height: 100dvh;
            padding: max(28px, env(safe-area-inset-top)) max(28px, env(safe-area-inset-right))
                max(28px, env(safe-area-inset-bottom)) max(28px, env(safe-area-inset-left));
            place-items: center;
        }

        .gra-error-card {
            width: min(760px, 100%);
            overflow: hidden;
            border: 1px solid #e0ebe4;
            border-radius: 20px;
            background: #ffffff;
            box-shadow: 0 24px 70px rgba(6, 69, 31, 0.14);
        }

        .gra-error-hero {
            position: relative;
            overflow: hidden;
            min-height: 210px;
            padding: 34px;
            background:
                radial-gradient(circle at 88% 12%, rgba(176, 222, 96, 0.22), transparent 28%),
                radial-gradient(circle at 62% 120%, rgba(36, 164, 88, 0.32), transparent 44%),
                linear-gradient(112deg, #043c1b 0%, #08602c 52%, #0d7839 100%);
        }

        .gra-error-hero::after {
            content: "404";
            position: absolute;
            right: 26px;
            bottom: -34px;
            color: rgba(255, 255, 255, 0.09);
            font-size: clamp(130px, 24vw, 210px);
            font-weight: 900;
            line-height: 1;
        }

        .gra-brand {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .gra-brand img {
            width: 78px;
            height: 78px;
            padding: 7px;
            border-radius: 50%;
            background: #ffffff;
            object-fit: contain;
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.18);
        }

        .gra-brand span {
            display: block;
            margin-bottom: 4px;
            color: rgba(255, 255, 255, 0.72);
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
        }

        .gra-brand strong {
            color: #ffffff;
            font-size: clamp(24px, 5vw, 34px);
            font-weight: 800;
        }

        .gra-error-content {
            padding: 42px 38px 46px;
            text-align: center;
        }

        .gra-error-icon {
            display: grid;
            width: 66px;
            height: 66px;
            margin: -74px auto 22px;
            position: relative;
            place-items: center;
            border: 6px solid #ffffff;
            border-radius: 18px;
            background: #eaf6ee;
            color: var(--gra-green);
            font-size: 29px;
            box-shadow: 0 10px 25px rgba(6, 69, 31, 0.12);
        }

        .gra-error-content h1 {
            margin: 0 0 10px;
            color: var(--gra-green-dark);
            font-size: 29px;
            font-weight: 850;
        }

        .gra-error-content p {
            max-width: 520px;
            margin: 0 auto 26px;
            color: var(--gra-muted);
            font-size: 15px;
            line-height: 1.7;
        }

        .gra-back-button {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            padding: 12px 21px;
            border-radius: 10px;
            background: var(--gra-green);
            color: #ffffff;
            font-size: 14px;
            font-weight: 750;
            text-decoration: none;
            box-shadow: 0 10px 24px rgba(13, 103, 51, 0.22);
            transition: transform 0.2s ease, background 0.2s ease, box-shadow 0.2s ease;
        }

        .gra-back-button:hover {
            background: var(--gra-green-dark);
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 14px 30px rgba(13, 103, 51, 0.28);
        }

        @media (max-width: 767.98px) {
            .gra-error-card {
                width: min(600px, 100%);
                border-radius: 16px;
            }

            .gra-error-hero {
                min-height: 195px;
                padding: 30px 26px;
            }

            .gra-error-hero::after {
                right: 8px;
                bottom: -22px;
                font-size: clamp(118px, 34vw, 170px);
            }

            .gra-error-content {
                padding: 40px 28px 38px;
            }

            .gra-error-content h1 {
                font-size: clamp(24px, 7vw, 29px);
            }
        }

        @media (max-width: 575.98px) {
            .gra-error-page {
                align-items: center;
                padding: max(14px, env(safe-area-inset-top)) max(14px, env(safe-area-inset-right))
                    max(14px, env(safe-area-inset-bottom)) max(14px, env(safe-area-inset-left));
            }

            .gra-error-card { border-radius: 14px; }
            .gra-error-hero { min-height: 184px; padding: 24px 20px; }
            .gra-brand { align-items: flex-start; flex-direction: column; gap: 12px; }
            .gra-brand img { width: 62px; height: 62px; }
            .gra-brand span { font-size: 11px; letter-spacing: 0.1em; }
            .gra-brand strong { display: block; font-size: 24px; line-height: 1.2; }
            .gra-error-content { padding: 38px 20px 28px; }
            .gra-error-icon { width: 60px; height: 60px; margin-top: -68px; font-size: 26px; }
            .gra-error-content p { margin-bottom: 22px; font-size: 14px; line-height: 1.6; }
            .gra-back-button { justify-content: center; width: 100%; min-height: 48px; }
        }

        @media (max-height: 520px) and (orientation: landscape) {
            .gra-error-page { padding-block: 12px; }
            .gra-error-card { display: grid; grid-template-columns: minmax(250px, 0.8fr) 1fr; }
            .gra-error-hero { min-height: 100%; }
            .gra-brand { align-items: flex-start; flex-direction: column; }
            .gra-error-content { display: grid; align-content: center; padding: 28px; }
            .gra-error-icon { margin: 0 auto 14px; }
            .gra-error-content p { margin-bottom: 18px; }
        }
    </style>
</head>
<body>
    <main class="gra-error-page">
        <section class="gra-error-card" aria-labelledby="graErrorTitle">
            <div class="gra-error-hero">
                <div class="gra-brand">
                    <img src="${pageContext.request.contextPath}/assets/images/NewLogo.png" alt="Lands Commission">
                    <div>
                        <span>GRA Reporting Portal</span>
                        <strong>Stamp Duty Report</strong>
                    </div>
                </div>
            </div>
            <div class="gra-error-content">
                <div class="gra-error-icon" aria-hidden="true"><i class="ri-map-pin-line"></i></div>
                <h1 id="graErrorTitle">Page not found</h1>
                <p>The page you requested is not available in the GRA reporting portal. Return to the report page to continue.</p>
                <a class="gra-back-button" href="${pageContext.request.contextPath}/gra_report">
                    <i class="ri-arrow-left-line"></i>
                    Return to GRA Report
                </a>
            </div>
        </section>
    </main>
</body>
</html>
