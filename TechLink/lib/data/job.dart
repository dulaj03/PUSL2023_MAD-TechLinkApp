import 'package:tech_link/model/jod.dart';

class JobData {
  static List<Job> jobs = [
    Job(
      id: '1',
      title: 'Senior Flutter Developer',
      company: 'Tech Solutions Inc.',
      location: 'Nugegoda, Colombo (Hybrid)',
      salary: '\Rs120K - \Rs150K',
      description:
          'Looking for an experienced Flutter developer to build robust mobile applications for our enterprise clients.',
      imageUrl: 'assets/techsolutionsgroupltd_cover.jpg',
      tags: ['Flutter', 'Mobile', 'Remote', 'Full-time'],
      postedDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Job(
      id: '2',
      title: 'Frontend Developer',
      company: 'Innovative Apps',
      location: 'San Francisco, CA',
      salary: '\$95K - \$120K',
      description:
          'Join our team to create engaging user interfaces using modern web technologies like React and Vue.',
      imageUrl: 'assets/innosoftwareworld_logo.jpg',
      tags: ['Frontend', 'React', 'Vue', 'On-site', 'Full-time'],
      postedDate: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Job(
      id: '3',
      title: 'Software Engineer',
      company: 'Global Systems Ltd.',
      location: 'Colombo, SriLanka (Hybrid)',
      salary: 'Rs70K - Rs90K',
      description:
          'Develop and maintain cloud-based enterprise software solutions for international clients.',
      imageUrl: 'assets/global.jpg',
      tags: ['Cloud', 'AWS', 'Java', 'Hybrid', 'Full-time'],
      postedDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Job(
      id: '4',
      title: 'Mobile App Developer',
      company: 'AppWorks Studio',
      location: 'Berlin, Germany',
      salary: '€65K - €85K',
      description:
          'Create beautiful and functional mobile apps for Android and iOS platforms using Flutter and native technologies.',
      imageUrl: 'assets/company_logos/appworks.png',
      tags: ['Mobile', 'Flutter', 'iOS', 'Android', 'Full-time'],
      postedDate: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Job(
      id: '5',
      title: 'Full Stack Developer',
      company: 'DataTech Solutions',
      location: 'Singapore (Remote)',
      salary: '\$90K - \$110K',
      description:
          'Work on all aspects of our data visualization platform, from backend services to user interfaces.',
      imageUrl: 'assets/company_logos/datatech.png',
      tags: ['Full Stack', 'Node.js', 'React', 'Remote', 'Full-time'],
      postedDate: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Job(
      id: '6',
      title: 'UX/UI Designer',
      company: 'Creative Minds',
      location: 'Toronto, Canada',
      salary: 'CAD 80K - 100K',
      description:
          'Design intuitive and beautiful user interfaces for web and mobile applications with focus on user experience.',
      imageUrl: 'assets/company_logos/creative_minds.png',
      tags: ['Design', 'UX', 'UI', 'Figma', 'On-site'],
      postedDate: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Job(
      id: '7',
      title: 'DevOps Engineer',
      company: 'Cloud Infrastructure Inc.',
      location: 'Austin, TX (Remote)',
      salary: '\$110K - \$140K',
      description:
          'Implement and manage CI/CD pipelines, containerization, and cloud infrastructure for enterprise applications.',
      imageUrl: 'assets/company_logos/cloud_infrastructure.png',
      tags: ['DevOps', 'AWS', 'Docker', 'Kubernetes', 'Remote'],
      postedDate: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Job(
      id: '8',
      title: 'Data Scientist',
      company: 'Analytics Pro',
      location: 'Boston, MA',
      salary: '\$125K - \$160K',
      description:
          'Apply machine learning and statistical analysis to extract insights from large datasets and develop predictive models.',
      imageUrl: 'assets/company_logos/analytics_pro.png',
      tags: ['Data Science', 'Python', 'ML', 'AI', 'Hybrid'],
      postedDate: DateTime.now(),
    ),
  ];

  // Helper method to get all jobs
  static List<Job> getAllJobs() {
    return jobs;
  }

  // Helper method to search jobs
  static List<Job> searchJobs(String query) {
    if (query.isEmpty) {
      return jobs;
    }

    final lowerQuery = query.toLowerCase();
    return jobs.where((job) {
      return job.title.toLowerCase().contains(lowerQuery) ||
          job.company.toLowerCase().contains(lowerQuery) ||
          job.description.toLowerCase().contains(lowerQuery) ||
          job.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  // Helper method to filter jobs by tags
  static List<Job> filterJobsByTags(List<String> filterTags) {
    if (filterTags.isEmpty) {
      return jobs;
    }

    return jobs.where((job) {
      return filterTags.every(
        (tag) =>
            job.tags.any((jobTag) => jobTag.toLowerCase() == tag.toLowerCase()),
      );
    }).toList();
  }

  // Helper method to sort jobs
  static List<Job> sortJobs(List<Job> jobList, String sortBy) {
    switch (sortBy) {
      case 'Date':
        return List.from(jobList)
          ..sort((a, b) => b.postedDate.compareTo(a.postedDate));
      case 'Salary':
        // This is a simplified example, as parsing salary ranges would be more complex
        return List.from(jobList)..sort((a, b) => b.salary.compareTo(a.salary));
      case 'Relevance':
      default:
        return jobList;
    }
  }
}
