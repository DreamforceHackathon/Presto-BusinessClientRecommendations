<?php

include_once("recommendations/activities.php");
include_once("recommendations/attractions.php");
include_once("recommendations/events.php");
include_once("recommendations/restaurants.php");
include_once("components/auth_configs.php");

define("DEFAULT_BUDGET_FOR_CLIENT" , 150); //in USD

init();

function init() {
    $eventParams = setSearchParams();
    $eventsObj = new events();
    $eventsObj->getEvents($eventParams);
}

//set search params Date, Location, Performer, Price Range
function setSearchParams() {
    $searchParams = new stdClass();
    if(isset($_GET)) {
        if(isset($_GET['zip'])) {
            $searchParams->zip = $_GET['zip'];
        } else {
            $searchParams->zip = 94101;
        }
        if(isset($_GET['date'])) {
            $searchParams->date = $_GET['date'];
        } else {
            $searchParams->date = date("F j, Y");
        }
        if(isset($_GET['budget'])) {
            $searchParams->budget = $_GET['budget'];
        } else {
            $searchParams->budget = DEFAULT_BUDGET_FOR_CLIENT;
        }
        if(isset($_GET['slug'])) {
            $searchParams->slug = explode(',' , $_GET['slug']);
        }
        if(isset($_GET['api'])) {
            $searchParams->api = $_GET['api'];
        }
        $searchParams->requestDate = date("F j, Y");
    }
    return $searchParams;
}

