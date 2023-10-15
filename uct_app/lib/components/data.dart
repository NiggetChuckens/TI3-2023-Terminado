
class Specialist {
  final String name;
  final String category;
  final double rating;
  final String image;

  const Specialist({
    required this.image,
    required this.name,
    required this.category,
    required this.rating,
  });
}

final List<Specialist> specialists = [
  const Specialist(name: 'Juan Perez', category: 'Terapia', rating: 4.5,  image: 'lib/images/cj.png'),
  const Specialist(name: 'Maria Garcia', category: 'Terapia', rating: 4.2, image: 'lib/images/doctor2.jpg'),
  const Specialist(name: 'Pedro Rodriguez', category: 'Psicologia', rating: 4.8, image: 'lib/images/doctor1.jpg'),
  const Specialist(name: 'Ana Martinez', category: 'Psicologia', rating: 4.6, image: 'lib/images/doctor2.jpg'),
  const Specialist(name: 'Luisa Fernandez', category: 'Psiquiatria', rating: 4.4, image: 'lib/images/doctor2.jpg'),
  const Specialist(name: 'Carlos Sanchez', category: 'Psiquiatria', rating: 4.1, image: 'lib/images/doctor2.jpg'),
  const Specialist(name: 'Jorge Ramirez', category: 'Doctor', rating: 4.9, image: 'lib/images/doctor2.jpg'),
  const Specialist(name: 'Laura Torres', category: 'Doctor', rating: 4.7, image: 'lib/images/doctor2.jpg'),
];