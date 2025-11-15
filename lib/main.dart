import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prathmesh Dongrikar — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Key to locate the projects section in the widget tree
  final GlobalKey _projectsKey = GlobalKey();

  // Called when "View Projects" button is clicked
  void _scrollToProjects() {
    final ctx = _projectsKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0, // top of the target visible
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Single scrollable area for the whole page
          child: Column(
            children: [
              HeroSection(onViewProjects: _scrollToProjects),
              const AboutSection(),
              // Pass the key to the container inside ProjectsSection by wrapping it here
              ProjectsSection(key: _projectsKey),
              const ContactSection(),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjects;
  const HeroSection({super.key, required this.onViewProjects});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: width < 600 ? width * 0.9 : 600,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Prathmesh Dongrikar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width < 600 ? 28 : 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Full Stack Developer • Flutter • Node.js • PostgreSQL',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width < 600 ? 14 : 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onViewProjects,
                child: const Text('View Projects'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double bodyFont = math.min(18, width * 0.04 + 12);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About Me', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text(
              "I’m a Full Stack Developer with 3+ years of experience building high-performance applications using Flutter, Node.js, and PostgreSQL. I specialize in creating scalable architectures, dynamic UI systems, and seamless user experiences across mobile and web. With a strong foundation in clean code, problem-solving, and DevOps practices, I enjoy turning ideas into reliable digital products.",
              style: TextStyle(fontSize: bodyFont, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  // Allow a Key to be attached (used for scrolling target)
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double cardWidth = 300;
    if (width < 700) {
      cardWidth = width * 0.9;
    } else if (width < 1000) {
      cardWidth = math.min(320, width * 0.45);
    }

    // The top-level Container has the key assigned from the parent (HomePage)
    return Container(
      // IMPORTANT: If this widget received a key, it will be attached to this Container.
      color: Colors.grey.shade50,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            Text('Projects', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: List.generate(3, (i) {
                return SizedBox(
                  width: cardWidth,
                  child: Card(
                    elevation: 1.5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Project ${i + 1}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Short description — tech used, links and screenshots.',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          children: [
            Text('Contact', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text('Email: prathmeshdongrikar@gmail.com'),
            const SizedBox(height: 12),
            // Download Resume button is intentionally commented out.
            /*
            ElevatedButton(
              onPressed: () {},
              child: const Text('Download Resume'),
            ),
            */
          ],
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: const Text('© Prathmesh Dongrikar'),
    );
  }
}
