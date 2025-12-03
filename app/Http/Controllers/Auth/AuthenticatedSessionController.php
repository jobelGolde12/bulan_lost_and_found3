<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Facades\Route;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response;

class AuthenticatedSessionController extends Controller
{
    /**
     * Display the login view.
     */
    public function create(): Response
    {
        return Inertia::render('Auth/Login', [
            'canResetPassword' => Route::has('password.request'),
            'status' => session('status'),
        ]);
    }

    /**
     * Handle an incoming authentication request.
     */
    public function store(LoginRequest $request): RedirectResponse
    {
        $this->ensureIsNotRateLimited($request); // Account lockout

        $request->authenticate();

        $request->session()->regenerate();

        $this->clearRateLimit($request);

        return redirect()->intended(route('dashboard', absolute: false));
    }

    /**
     * Ensure the login request is not rate-limited.
     *
     * @throws ValidationException
     */
    protected function ensureIsNotRateLimited(Request $request): void
    {
        $key = $this->throttleKey($request);

        if (RateLimiter::tooManyAttempts($key, 2)) { // pero sa frontent 3 attemps
            $seconds = RateLimiter::availableIn($key);

            throw ValidationException::withMessages([
                'email' => [
                    "Too many login attempts.",
                ],
            ]);
        }

        RateLimiter::hit($key, 60); // Lock for 60 seconds after too many attempts
    }

    /**
     * Clear the rate limit for the user after a successful login.
     */
    protected function clearRateLimit(Request $request): void
    {
        $key = $this->throttleKey($request);
        RateLimiter::clear($key);
    }

    /**
     * Generate a unique key for rate-limiting based on the request.
     */
    protected function throttleKey(Request $request): string
    {
        return 'login|' . $request->ip() . '|' . $request->input('email');
    }

    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request): RedirectResponse
    {
        Auth::guard('web')->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect('/');
    }
}
