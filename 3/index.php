<?php

function getTuesdayCountByDates(string $start, string $end): int
{
    $startDate = date_create($start);
    $endDate = date_create($end);

    $interval = DateInterval::createFromDateString('1 day');
    $dateRange = new DatePeriod($startDate, $interval ,$endDate);

    $countTuesday = 0;
    foreach ($dateRange as $date) {
        $dayName = date('l', strtotime($date->format('Y-m-d')));
        if ($dayName === 'Tuesday') {
            $countTuesday++;
        }
    }

    return $countTuesday;
}

echo getTuesdayCountByDates('2023-01-01', '2023-02-08');