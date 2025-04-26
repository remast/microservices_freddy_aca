package main

import (
	"encoding/json"
	"net/http"

	"github.com/go-chi/chi/v5"
)

type Quote struct {
	Age     int      `json:"age"`
	Breed   string   `json:"breed"`
	Tariffs []Tariff `json:"tariffs"`
}

type Tariff struct {
	Name string  `json:"name"`
	Rate float64 `json:"rate"`
}

func HandleQuote(w http.ResponseWriter, r *http.Request) {
	// 1. JSON Request lesen
	var quote Quote
	json.NewDecoder(r.Body).Decode(&quote)

	// 2. Tarif berechnen
	tariff := Tariff{Name: "Dog OP _ Basic", Rate: 12.4}
	quote.Tariffs = []Tariff{tariff}

	// 3. JSON Response schreiben
	json.NewEncoder(w).Encode(quote)
}

func main() {
	r := chi.NewRouter()

	r.Post("/api/quote", HandleQuote)

	http.ListenAndServe(":8080", r)
}
