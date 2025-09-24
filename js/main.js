const toggler = document.querySelector('.menu-toggle');
const navCollapse = document.querySelector('.nav-collapse');
toggler.addEventListener('click', () => {
    if (navCollapse.classList.contains('show')) {
        navCollapse.classList.remove('show');
    } else {
        navCollapse.classList.add('show');
    }
});

document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        const href = this.getAttribute('href');
        if (href.length > 1) {
            e.preventDefault();
            const target = document.querySelector(href);
            if (target) target.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    });
});

const sections = document.querySelectorAll('main section[id]');
const navLinksList = document.querySelectorAll('.navbar .nav-link');
function onScroll() {
    const scrollPos = window.scrollY + 120;
    sections.forEach(sec => {
        if (sec.offsetTop <= scrollPos && (sec.offsetTop + sec.offsetHeight) > scrollPos) {
            navLinksList.forEach(link => link.classList.remove('active'));
            const activeLink = document.querySelector('.navbar a[href="#' + sec.id + '"]');
            if (activeLink) activeLink.classList.add('active');
        }
    });
}
window.addEventListener('scroll', onScroll);

const btnTopo = document.getElementById('voltar-topo');
window.addEventListener('scroll', () => {
    if (window.scrollY > 400) btnTopo.style.display = 'flex'; else btnTopo.style.display = 'none';
});
btnTopo.addEventListener('click', () => { window.scrollTo({ top: 0, behavior: 'smooth' }); });
