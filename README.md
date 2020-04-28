# Sweater Weather
Sweater Weather is a [Turing](https://turing.io/) back end solo project that aggregates data from multiple APIs and exposes it in JSON format to a hypothetical front end for the purpose of planning roadtrips.

## APIs consumed
[Google Geocoding](https://developers.google.com/maps/documentation/geocoding/intro)

[Google Directions](https://developers.google.com/maps/documentation/directions/intro)

[Pexels Photos and Videos](https://www.pexels.com/api/documentation/)

[OpenWeather One Call](https://openweathermap.org/api/one-call-api)

## Endpoints

### Forecast
`GET /api/v1/forecast`

| Params | Example |
| --- | --- |
| location | Denver,CO |

```JSON
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "location": "Denver, Co",
            "geocode": {
                "lat": 39.91424689999999,
                "long": -104.6002959,
                "country": "United States"
            },
            "current_weather": {
                "time": "6:05 PM, April 27",
                "sunrise": "6:02 AM",
                "sunset": "7:48 PM",
                "feels_like": 69,
                "humidity": 15,
                "visibility": 10,
                "uvi": 8,
                "description": "Clouds",
                "high": 77,
                "low": 65
            },
            "hourly_weather": [
                {
                    "date": "6 PM",
                    "temp": 77,
                    "icon": "02d",
                    "description": "few clouds"
                },
                {
                    "date": "7 PM",
                    "temp": 73,
                    "icon": "03d",
                    "description": "scattered clouds"
                },
                {
                    "date": "8 PM",
                    "temp": 67,
                    "icon": "03n",
                    "description": "scattered clouds"
                },
                {
                    "date": "9 PM",
                    "temp": 65,
                    "icon": "04n",
                    "description": "broken clouds"
                },
                {
                    "date": "10 PM",
                    "temp": 65,
                    "icon": "04n",
                    "description": "broken clouds"
                },
                {
                    "date": "11 PM",
                    "temp": 62,
                    "icon": "04n",
                    "description": "broken clouds"
                },
                {
                    "date": "12 AM",
                    "temp": 61,
                    "icon": "04n",
                    "description": "broken clouds"
                },
                {
                    "date": "1 AM",
                    "temp": 59,
                    "icon": "04n",
                    "description": "overcast clouds"
                }
            ],
            "daily_weather": [
                {
                    "day": "Monday",
                    "max": 77,
                    "min": 65,
                    "description": "Clouds",
                    "icon": "02d"
                },
                {
                    "day": "Tuesday",
                    "max": 71,
                    "min": 44,
                    "description": "Clear",
                    "icon": "01d"
                },
                {
                    "day": "Wednesday",
                    "max": 68,
                    "min": 38,
                    "description": "Clear",
                    "icon": "01d"
                },
                {
                    "day": "Thursday",
                    "max": 83,
                    "min": 51,
                    "description": "Clouds",
                    "icon": "04d"
                },
                {
                    "day": "Friday",
                    "max": 82,
                    "min": 53,
                    "description": "Rain",
                    "icon": "10d",
                    "rain": 1
                },
                {
                    "day": "Saturday",
                    "max": 73,
                    "min": 48,
                    "description": "Rain",
                    "icon": "10d",
                    "rain": 8
                },
                {
                    "day": "Sunday",
                    "max": 76,
                    "min": 50,
                    "description": "Rain",
                    "icon": "10d",
                    "rain": 2
                }
            ]
        }
    }
}

### Backgrounds
`GET /api/v1/backgrounds`
| Params | Example |
| --- | --- |
| location | Denver,CO |

```JSON
{
    "data": {
        "id": null,
        "type": "background",
        "attributes": {
            "location": "denver",
            "image_url": {
                "image": "https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"
            }
        }
    }
}
```

### User Registration
`POST /api/v1/users`
| Params | Example |
| --- | --- |
| email | whatever3000@example.com |
| password | password |
| password_confirmation | password |

```JSON
{
    "data": {
        "id": "3",
        "type": "users",
        "attributes": {
            "email": "whatever3000@example.com",
            "api_key": "a525d7d523f64af8b29b3139601bcd80"
        }
    }
}
```

### User Login
`POST /api/v1/sessions`
| Params | Example |
| --- | --- |
| email | whatever3000@example.com |
| password | password |

```JSON
{
    "data": {
        "id": "3",
        "type": "users",
        "attributes": {
            "api_key": "a525d7d523f64af8b29b3139601bcd80"
        }
    }
}
```

### Road Trip
`POST /api/v1/road_trip`
| Params | Example |
| --- | --- |
| api_key | a525d7d523f64af8b29b3139601bcd80 |
| origin | Denver,CO |
| destination | Montclair,CA |

```JSON
{
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "origin": "Denver,CO",
            "destination": "Montclair,CA",
            "travel_time": "15 hours",
            "arrival_forecast": "89, Clear Sky"
        }
    }
}
```
