import { useEffect, useState } from 'react';
import { getBooks } from '../api/booksApi';

export function useBooks() {
  const [books, setBooks] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    getBooks()
      .then(setBooks)
      .catch(err => setError(err.message))
      .finally(() => setLoading(false));
  }, []);

  return { books, loading, error };
}
