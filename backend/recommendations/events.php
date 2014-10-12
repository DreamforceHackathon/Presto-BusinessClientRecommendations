<?php
/**
 * Created by PhpStorm.
 * User: vasjain
 * Date: 10/11/14
 * Time: 10:09 AM
 */
include_once("components/auth_configs.php");
include_once("yelp.php");

class events {

    function getEvents($eventParams) {
        $zippyObject = self::getCityByZipCode($eventParams->zip);
        foreach($zippyObject->places as $place) {
            $eventParams->city = $place->{'place name'};
            break;
        }
        $moviesObject = self::getMovies($eventParams->zip, $eventParams->date);
        $sportsObject = self::getSports(urlencode($eventParams->city));
        $concertsObject = self::getConcerts(urlencode($eventParams->city));
        $restaurantsObject = self::getRestaurants(urlencode($eventParams->city));
        print_r($restaurantsObject);
    }

    function getRestaurants($city) {
        $longopts  = array("location::" . $city,);
        $options = getopt("", $longopts);
        $term = $options['term'] ?: '';
        $location = $options['location'] ?: '';
        $businesses = query_api($term, $location);
        $businessesArray = array();
        foreach($businesses->businesses as $business) {
            $businessJson = new stdClass();
            $businessJson->eventname = $business->name;
            $businessJson->category = "Food&Dining";
            $businessJson->subcategory = "Restaurants";
            $businessJson->price = rand(25, 50);
            $businessJson->image = "http://news.nextglass.co/wp-content/uploads/2014/08/food_and_fine_wine-wide.jpg";
            $businessJson->time = rand(1, 2);

            $addressArray = array();
            foreach($business->location->display_address as $addressTuple) {
                array_push($addressArray, $addressTuple);
            }
            $businessJson->location = $addressArray;
            $businessMetaData = new stdClass();
            $businessMetaData->shortdescription = $business->description;
            $businessMetaData->mobile_url = $business->mobile_url;
            $businessMetaData->review_count = $business->review_count;
            $businessMetaData->url = $business->url;
            $businessMetaData->phone = $business->phone;
            $businessMetaData->display_phone = $business->display_phone;
            $businessJson->metadata = $businessMetaData;
            array_push($businessesArray, $businessJson);
        }
        return json_encode($businessesArray);
    }

    /**
     *
     * http://api.eventful.com/json/events/search?category=concerts&location=san+francisco&app_key=<key>
     *
     * @param $city
     * @return $data
     */
    function getConcerts($city) {
        $url = EVENTFUL_EVENT_SEARCH_API_URL . "?category=" . EVENTFUL_MUSIC_CATEGORY . "&location=" . $city . "&app_key=" . EVENTFUL_API_KEY;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $data = curl_exec($ch);
        curl_close($ch);

        $concerts = json_decode($data);
        $concertsArray = array();
        foreach($concerts->events->event as $concert) {
            $concertJson = new stdClass();
            $concertJson->eventname = $concert->title;
            $concertJson->category = "Events";
            $concertJson->subcategory = "Concerts";
            $concertJson->price = rand(50, 100);
            $concertJson->image = "http://cdn1.ticketsinventory.com/images/last_photos/concert/M/monster-massive/monster-massive-tickets-silverado_13033947377877.png";
            $concertJson->time = rand(2, 4);
            $concertJson->location = $concert->venue_name . ", " . $concert->venue_address . ", " . $concert->city_name . ", " . $concert->region_name . ", " . $concert->postal_code;

            $concertMetaData = new stdClass();
            $concertMetaData->shortdescription = $concert->description;
            $concertMetaData->startTime = $concert->start_time;
            $concertMetaData->endTime = $concert->stop_time;
            $concertMetaData->url = $concert->url;
            $concertMetaData->venue_url = $concert->venue_url;
            $concertMetaData->latitude = $concert->latitude;
            $concertMetaData->longitude = $concert->longitude;
            $concertJson->metadata = $concertMetaData;
            array_push($concertsArray, $concertJson);
        }
        return json_encode($concertsArray);
    }

    /**
     *
     * http://api.eventful.com/json/events/search?category=sports&location=san+francisco&app_key=<key>
     * http://api.eventful.com/docs/events/search
     *
     * @param $city
     * @return $data
     */
    function getSports($city) {
        $url = EVENTFUL_EVENT_SEARCH_API_URL . "?category=" . EVENTFUL_SPORTS_CATEGORY . "&location=" . $city . "&app_key=" . EVENTFUL_API_KEY;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $data = curl_exec($ch);
        curl_close($ch);

        $sports = json_decode($data);
        $sportsArray = array();
        foreach($sports->events->event as $sport) {
            $sportJson = new stdClass();
            $sportJson->eventname = $sport->title;
            $sportJson->category = "Events";
            $sportJson->subcategory = "Sports";
            $sportJson->price = rand(30, 75);
            $sportJson->image = "http://www.bigbentavern.com/wp-content/uploads/2013/01/all-sports-banner.png";
            $sportJson->time = "3 Hours"; //($sportJson->endTime)-($sportJson->startTime)
            $sportJson->location = $sport->venue_name . ", " . $sport->venue_address . ", " . $sport->city_name . ", " . $sport->region_name . ", " . $sport->postal_code;

            $sportMetaData = new stdClass();
            $sportMetaData->shortdescription = $sport->description;
            $sportMetaData->startTime = $sport->start_time;
            $sportMetaData->endTime = $sport->stop_time;
            $sportMetaData->url = $sport->url;
            $sportMetaData->venue_url = $sport->venue_url;
            $sportMetaData->latitude = $sport->latitude;
            $sportMetaData->longitude = $sport->longitude;
            $sportJson->metadata = $sportMetaData;
            array_push($sportsArray, $sportJson);
        }
        return json_encode($sportsArray);
    }

    /*
     * http://developer.tmsapi.com/docs/read/data_v1/movies/Movie_showtimes_by_zip_code
     * @param $zip
     */
    static function getMovies($zip) {
        $startDate = date("Y-m-d");
        $url = MOVIE_API_URL . "?api_key=" . MOVIE_API_KEY . "&zip=" . $zip . "&startDate=" . $startDate;
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $data = curl_exec($ch);
        curl_close($ch);
        $moviesArray = array();
        $movies = json_decode($data);
        foreach($movies as $movie) {
            $movieJson = new stdClass();
            $movieJson->eventname = $movie->title;
            $movieJson->category = "Events";
            $movieJson->subcategory = "Movies";
            $movieJson->price = rand(12, 20);
            $movieJson->image = $movie->preferredImage;
            $movieJson->time = $movie->runTime;
            $movieJson->location = $zip;

            $movieMetaData = new stdClass();
            $movieMetaData->shortdescription = $movie->shortDescription;
            $movieMetaData->rating = "";
            $movieMetaData->ratings = array();
            foreach($movie->ratings as $rating) {
                array_push($movieMetaData->ratings, $rating->code);
            }
            $movieMetaData->releaseYear = $movie->releaseYear;

            $showTimings = array();
            foreach($movie->showtimes as $showtime) {
                $showtimeObject = new stdClass();
                $showtimeObject->theatrename = $showtime->theatre->name;
                $showtimeObject->dateTime = $showtime->dateTime;
                $showtimeObject->ticketURI = $showtime->ticketURI;
                array_push($showTimings, $showtimeObject);
            }
            $movieMetaData->showtimings = $showTimings;
            $movieJson->metadata = $movieMetaData;
            array_push($moviesArray, $movieJson);
        }
        return json_encode($moviesArray);
    }

    /*
     *
     * Structure: api.zippopotam.us/country/postal-code
     * Example: api.zippopotam.us/us/90210
     * NEW! City->Zip: api.zippopotam.us/country/state/city
     * Example: api.zippopotam.us/us/ma/belmont
     */
    function getCityByZipCode($zipcode) {
        $url = "api.zippopotam.us/us/" . $zipcode;
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $zipData = curl_exec($ch);
        return(json_decode($zipData));
    }

    function getTimeDifference($start_time, $stop_time) {
        $years = substr($stop_time, 0, 4) - substr($start_time, 0, 4);
        $months = $years * 12 + substr($stop_time, 5, 2) - substr($start_time, 5, 2);
        $days = $months * 30 + substr($stop_time, 8, 2) - substr($start_time, 8, 2);
        $hours = $days * 24 + substr($stop_time, 11, 2) - substr($start_time, 11, 2);
        $minutes = $hours * 60 + substr($stop_time, 14, 2) - substr($start_time, 14, 2);
        $duration = $minutes/60;
        return $duration;
    }
} 