<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class SemaphoreService
{
   protected $apiKey;

    public function __construct()
    {
        $this->apiKey = env('SEMAPHORE_API_KEY');
    }

    public function sendSMS($to, $message)
    {
        $response = Http::asForm()->post('https://semaphore.co/api/v4/messages', [
            'apikey' => $this->apiKey,
            'number' => $to,
            'message' => $message,
            'sendername' => env('SEMAPHORE_SENDER_NAME', 'SEMAPHORE'),
        ]);

          Log::info('Semaphore SMS Response', [
            'to'       => $to,
            'message'  => $message,
            'response' => $response->json(),
          ]);

        return $response->json();
    }
}
