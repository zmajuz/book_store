import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:3000/api/v1'
});

export const getBooks = async () => {
  const response = await api.get('/books');
  return response.data.data.map(book => ({
    id: book.id,
    ...book.attributes
  }));
};
