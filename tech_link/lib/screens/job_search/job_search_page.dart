import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tech_link/data/job.dart';
import 'package:tech_link/model/jod.dart';
import 'package:tech_link/providers/user_provider.dart';
import 'package:tech_link/widgets/job_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Job> _filteredJobs = [];
  List<String> _activeFilters = [];
  String _sortOption = 'Relevance';

  @override
  void initState() {
    super.initState();
    _filteredJobs = JobData.getAllJobs();

    _searchController.addListener(() {
      _filterJobs();
    });
  }

  void _filterJobs() {
    final query = _searchController.text;
    setState(() {
      // First search by query
      var results = JobData.searchJobs(query);

      // Then filter by tags if any are active
      if (_activeFilters.isNotEmpty) {
        results = JobData.filterJobsByTags(_activeFilters);
      }

      // Finally sort the results
      _filteredJobs = JobData.sortJobs(results, _sortOption);
    });
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (_activeFilters.contains(filter)) {
        _activeFilters.remove(filter);
      } else {
        _activeFilters.add(filter);
      }
      _filterJobs();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 145, 228, 162),
        body: Column(
          children: [
            // Search header with profile picture
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  // Search bar
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 145, 228, 162),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for jobs...',
                          hintStyle: GoogleFonts.chakraPetch(
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[600],
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      final user = userProvider.user;
                      return ClipOval(
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child:
                              user != null
                                  ? FadeInImage.assetNetwork(
                                    placeholder: 'assets/icon_bg_F.jpg',
                                    image: user.profilePictureURL,
                                    fit: BoxFit.cover,
                                    imageErrorBuilder: (
                                      context,
                                      error,
                                      stackTrace,
                                    ) {
                                      return const Icon(Icons.error);
                                    },
                                    placeholderFit: BoxFit.cover,
                                    fadeInDuration: const Duration(
                                      milliseconds: 500,
                                    ),
                                    fadeInCurve: Curves.easeIn,
                                  )
                                  : Image.asset(
                                    'assets/icon_bg_F.jpg',
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Filter and sort options
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFilterChip(
                      'Remote',
                      _activeFilters.contains('Remote'),
                    ),
                    _buildFilterChip(
                      'Full-time',
                      _activeFilters.contains('Full-time'),
                    ),
                    _buildFilterChip(
                      'Flutter',
                      _activeFilters.contains('Flutter'),
                    ),
                    _buildFilterChip('React', _activeFilters.contains('React')),
                    _buildFilterChip(
                      'Mobile',
                      _activeFilters.contains('Mobile'),
                    ),
                  ],
                ),
              ),
            ),

            // Search results info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    '${_filteredJobs.length} jobs found',
                    style: GoogleFonts.chakraPetch(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  if (_activeFilters.isNotEmpty ||
                      _searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchController.clear();
                          _activeFilters.clear();
                          _filteredJobs = JobData.getAllJobs();
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 16,
                            color: const Color.fromARGB(255, 7, 59, 58),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Clear all',
                            style: GoogleFonts.chakraPetch(
                              color: const Color.fromARGB(255, 7, 59, 58),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Job results
            Expanded(
              child:
                  _filteredJobs.isEmpty
                      ? _buildNoResultsFound()
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredJobs.length,
                        itemBuilder: (context, index) {
                          final job = _filteredJobs[index];
                          return JobCard(
                            title: job.title,
                            company: job.company,
                            location: job.location,
                            salary: job.salary,
                            description: job.description,
                            imageUrl: job.imageUrl,
                            tags: job.tags,
                            onTap: () {
                              // Navigate to job details page
                            },
                            job: job,
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return GestureDetector(
      onTap: () => _toggleFilter(label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color:
              isActive
                  ? const Color.fromARGB(255, 146, 227, 169)
                  : const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.chakraPetch(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? Colors.black : Colors.black87,
              ),
            ),
            if (isActive) ...[
              const SizedBox(width: 4),
              const Icon(Icons.close, size: 16, color: Colors.black54),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: GoogleFonts.chakraPetch(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or filters',
            style: GoogleFonts.chakraPetch(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
