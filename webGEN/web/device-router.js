(function () {
    var MOBILE_BREAKPOINT = 900;
    var TOUCH_VIEWPORT_BREAKPOINT = 1180;
    var LANDING_GUARD_KEY = '__demoIndexRouterLanding';
    var LANDING_GUARD_MS = 1600;
    var forceView = new URLSearchParams(window.location.search).get('view');

    if (forceView === 'desktop' || forceView === 'mobile') {
        return;
    }

    function isMobileDevice() {
        var userAgent = navigator.userAgent || navigator.vendor || '';
        var mobileAgent = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(userAgent);
        var touchCapable = navigator.maxTouchPoints > 1;
        var appleTouchDesktopAgent = /Macintosh/i.test(userAgent) && (/Mobile/i.test(userAgent) || touchCapable);
        var coarsePointer = window.matchMedia && window.matchMedia('(pointer: coarse)').matches;
        var narrowViewport = window.matchMedia && window.matchMedia('(max-width: ' + MOBILE_BREAKPOINT + 'px)').matches;
        var touchViewportMobile = touchCapable && Math.min(window.innerWidth || Number.MAX_SAFE_INTEGER, screen.width || Number.MAX_SAFE_INTEGER) <= TOUCH_VIEWPORT_BREAKPOINT;

        return mobileAgent || appleTouchDesktopAgent || (coarsePointer && narrowViewport) || touchViewportMobile;
    }

    function isInMobileFolder(pathname) {
        return pathname === '/mobile' || pathname === '/mobile/' || pathname.indexOf('/mobile/') === 0 || pathname.indexOf('/web/mobile/') !== -1;
    }

    function getMobilePath(pathname) {
        if (pathname.indexOf('/web/') !== -1) {
            return pathname.replace(/\/web\//, '/web/mobile/');
        }

        if (pathname === '/') {
            return '/mobile/';
        }

        return '/mobile' + pathname;
    }

    function getDesktopPath(pathname) {
        if (pathname.indexOf('/web/mobile/') !== -1) {
            return pathname.replace('/web/mobile/', '/web/');
        }

        if (pathname === '/mobile' || pathname === '/mobile/') {
            return '/';
        }

        if (pathname.indexOf('/mobile/') === 0) {
            return pathname.replace('/mobile', '') || '/';
        }

        return pathname;
    }

    function recentlyLandedOn(pathname) {
        try {
            var rawState = sessionStorage.getItem(LANDING_GUARD_KEY);
            if (!rawState) {
                return false;
            }

            var state = JSON.parse(rawState);
            if (!state || state.path !== pathname || typeof state.at !== 'number') {
                return false;
            }

            if (Date.now() - state.at > LANDING_GUARD_MS) {
                sessionStorage.removeItem(LANDING_GUARD_KEY);
                return false;
            }

            return true;
        } catch (error) {
            return false;
        }
    }

    function markRedirectLanding(pathname) {
        try {
            sessionStorage.setItem(LANDING_GUARD_KEY, JSON.stringify({ path: pathname, at: Date.now() }));
        } catch (error) {
            return;
        }
    }

    function getRedirectPath(pathname, mobileTarget) {
        var inMobileFolder = isInMobileFolder(pathname);

        if (mobileTarget && !inMobileFolder) {
            return getMobilePath(pathname);
        }

        if (!mobileTarget && inMobileFolder) {
            return getDesktopPath(pathname);
        }

        return null;
    }

    var currentUrl = new URL(window.location.href);

    if (recentlyLandedOn(currentUrl.pathname)) {
        return;
    }

    var redirectPath = getRedirectPath(currentUrl.pathname, isMobileDevice());

    if (!redirectPath || redirectPath === currentUrl.pathname) {
        return;
    }

    markRedirectLanding(redirectPath);
    currentUrl.pathname = redirectPath;
    window.location.replace(currentUrl.toString());
})();
