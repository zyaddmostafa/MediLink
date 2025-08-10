// Generate dummy data for skeleton loading
import '../../feature/home/data/model/doctor_model.dart';

List<DoctorModel> generateSkeletonDoctors() {
  return List.generate(
    5,
    (index) => DoctorModel(
      id: index,
      name: 'Dr. Loading Name',
      email: 'loading@email.com',
      phone: '123-456-7890',
      photo: '',
      gender: 'male',
      address: 'Loading Address',
      description: 'Loading description for skeleton',
      degree: 'MBBS',
      specialization: Specialization(id: 1, name: 'Loading'),
      city: City(id: 1, name: 'Loading City', governrate: null),
      appointPrice: 100,
      startTime: '09:00:00',
      endTime: '17:00:00',
    ),
  );
}
