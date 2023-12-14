module ApplicationHelper

  def canonical_url
    request.original_url
  end

  def event_jsonld(event)
    {
      "@context": "http://schema.org",
      "@type": "Event",
      "name": event.title,
      "startDate": event.date.iso8601,
      "description": event.program,
      "location": {
        "@type": "Place",
        "name": event.city_name
      }
    }.to_json.html_safe
  end

end
