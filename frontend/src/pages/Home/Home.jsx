import BookList from "../../components/BookList/BookList";
import { useBooks } from "../../hooks/useBooks";

export default function Home() {
  const { books, loading } = useBooks();

  if (loading) return <p className="text-center mt-10">Carregando livros...</p>;

  return (
    <div className="container mx-auto p-6">
      <BookList books={books} />
    </div>
  );
}
