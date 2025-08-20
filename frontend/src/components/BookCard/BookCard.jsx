export default function BookCard({ book }) {
    return (
      <div className="border rounded-lg p-4 shadow hover:shadow-lg transition flex flex-col items-center">
        <img
          src={book.imageUrl}
          alt={book.title}
          className="w-48 h-64 object-cover mb-4"
        />
        <h3 className="text-lg font-bold text-center">{book.title}</h3>
        <p className="text-gray-600 text-center mb-2">{book.author}</p>
        <span className="text-red-600 font-semibold">{book.price}</span>
      </div>
    );
}
