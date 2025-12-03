<?php

namespace App\Console\Commands;

use App\Models\ItemModel;
use Illuminate\Console\Command;
use Illuminate\Support\Carbon;

class DeleteOldUnclaimedItems extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'items:delete-old-unclaimed';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Delete items that are older than 1 year and not claimed';

    /**
     * Execute the console command.
     */

    public function handle()
    {
        $oneYearAgo = Carbon::now()->subYear();

        $deleted = ItemModel::where('created_at', '<=', $oneYearAgo)
                    ->where('claimed_at' , '!=', 'Claimed')
                    ->delete();

        $this->info("Deleted {$deleted} old unclaimed items.");
    }
}
