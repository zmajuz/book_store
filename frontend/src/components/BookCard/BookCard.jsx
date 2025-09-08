import { formatCurrency } from '../../utils/formatters';

export default function BookCard({ book }) {
  return (
    <div className="bg-white rounded-lg hover:shadow-lg transition flex flex-col items-center">
      <img
        src={book.cover_image_url}
        alt={book.title}
        className="w-full h-64 object-contain mb-1"
      />
      <h3 className="text-base font-semibold text-center text-gray-800 mb-1">{book.title}</h3>
      <p className="text-sm text-gray-500 text-center mb-2">{book.author}</p>
      <span className="text-red-600 font-bold">{formatCurrency(book.price)}</span>
    </div>
  );
}
