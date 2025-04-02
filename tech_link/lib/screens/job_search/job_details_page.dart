import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_link/model/jod.dart'; // Make sure this path is correct

class JobDetailsPage extends StatefulWidget {
  final Job job;

  const JobDetailsPage({Key? key, required this.job}) : super(key: key);

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  bool _isSaved = false;
  bool _isApplied = false;

  @override
  void initState() {
    super.initState();
    // In a real app, you would check if the job is already saved or applied
    // Make sure your Job model has isSaved property or null-check it
    _isSaved = widget.job.isSaved ?? false;
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });
    // In a real app, you would update this in your database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSaved ? 'Job saved!' : 'Job removed from saved'),
        backgroundColor: const Color.fromARGB(255, 7, 59, 58),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _applyForJob() {
    setState(() {
      _isApplied = true;
    });
    // In a real app, you would handle the job application
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Application submitted successfully!'),
        backgroundColor: Color.fromARGB(256, 9, 56, 60),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isSaved ? Icons.bookmark : Icons.bookmark_border,
              color:
                  _isSaved
                      ? const Color.fromARGB(255, 145, 228, 162)
                      : Colors.grey[600],
            ),
            onPressed: _toggleSave,
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ],
        title: Text(
          'Job Details',
          style: GoogleFonts.chakraPetch(
            color: Colors.darkgray,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Company logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.job.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.business,
                            color: Colors.grey[400],
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 20),

                  // Job title and company info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.job.title,
                          style: GoogleFonts.chakraPetch(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.job.company,
                          style: GoogleFonts.chakraPetch(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                widget.job.location,
                                style: GoogleFonts.chakraPetch(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Job details
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overview section
                  Text(
                    'Overview',
                    style: GoogleFonts.chakraPetch(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Key info cards
                  Row(
                    children: [
                      _buildInfoCard(
                        icon: Icons.money,
                        title: 'Salary',
                        value: widget.job.salary,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoCard(
                        icon: Icons.work_outline,
                        title: 'Job Type',
                        value:
                            widget.job.tags?.contains('Full-time') == true
                                ? 'Full-time'
                                : 'Contract',
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildInfoCard(
                        icon: Icons.schedule,
                        title: 'Experience',
                        value: '2-5 years',
                        color: Colors.green,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoCard(
                        icon: Icons.calendar_today,
                        title: 'Posted On',
                        value: _formatDate(
                          DateTime.now().subtract(const Duration(days: 3)),
                        ),
                        color: Colors.green,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Tags section
                  if (widget.job.tags != null &&
                      widget.job.tags!.isNotEmpty) ...[
                    Text(
                      'Skills',
                      style: GoogleFonts.chakraPetch(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.darkgray,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          widget.job.tags!
                              .map(
                                (tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      146,
                                      227,
                                      169,
                                    ).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                        255,
                                        146,
                                        227,
                                        169,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    tag,
                                    style: GoogleFonts.chakraPetch(
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                        255,
                                        7,
                                        59,
                                        58,
                                      ),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 26),
                  ],

                  // Description section
                  Text(
                    'Job Description',
                    style: GoogleFonts.chakraPetch(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.darkgray,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.job.description,
                    style: GoogleFonts.chakraPetch(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 26),

                  // Responsibilities section
                  Text(
                    'Responsibilities',
                    style: GoogleFonts.chakraPetch(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildBulletPoint(
                    'Design, develop and maintain high-quality mobile applications',
                  ),
                  _buildBulletPoint(
                    'Collaborate with cross-functional teams to define, design, and ship new features',
                  ),
                  _buildBulletPoint(
                    'Ensure the performance, quality, and responsiveness of applications',
                  ),
                  _buildBulletPoint(
                    'Identify and correct bottlenecks and fix bugs',
                  ),
                  _buildBulletPoint(
                    'Help maintain code quality, organization, and automatization',
                  ),

                  const SizedBox(height: 26),

                  // Requirements section
                  Text(
                    'Requirements',
                    style: GoogleFonts.chakraPetch(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildBulletPoint(
                    'Bachelors degree in Computer Science or related field',
                  ),
                  _buildBulletPoint(
                    '2+ years of experience with mobile app development',
                  ),
                  _buildBulletPoint(
                    'Strong knowledge of ${widget.job.tags != null && widget.job.tags!.isNotEmpty ? widget.job.tags!.join(", ") : "modern technologies"}',
                  ),
                  _buildBulletPoint(
                    'Experience with RESTful APIs and third-party libraries',
                  ),
                  _buildBulletPoint(
                    'Solid understanding of the full mobile development life cycle',
                  ),

                  const SizedBox(height: 26),

                  // Benefits section
                  Text(
                    'Benefits',
                    style: GoogleFonts.chakraPetch(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.darkgray,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildBulletPoint(
                    'Competitive salary package: ${widget.job.salary}',
                  ),
                  _buildBulletPoint(
                    'Flexible working hours and remote work options',
                  ),
                  _buildBulletPoint('Health insurance and wellness programs'),
                  _buildBulletPoint(
                    'Professional development and learning opportunities',
                  ),
                  _buildBulletPoint('Modern office with great amenities'),

                  const SizedBox(height: 42),

                  // Company section
                  Text(
                    'About ${widget.job.company}',
                    style: GoogleFonts.chakraPetch(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We are a leading technology company focused on creating innovative solutions that transform industries. With a team of passionate experts, we develop cutting-edge software that solves real-world problems.',
                    style: GoogleFonts.chakraPetch(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _isApplied ? null : _applyForJob,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 7, 59, 58),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _isApplied ? 'Applied' : 'Apply Now',
                  style: GoogleFonts.chakraPetch(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.chakraPetch(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.chakraPetch(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•',
            style: GoogleFonts.chakraPetch(
              fontSize: 18,
              color: const Color.fromARGB(255, 145, 228, 162),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.chakraPetch(
                fontSize: 16,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
