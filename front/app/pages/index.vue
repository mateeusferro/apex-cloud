<template>
    <div class="min-h-screen bg-white p-6 flex items-center justify-center">
        <div class="max-w-xl w-full text-center">
            <h1 class="text-3xl font-light text-gray-900 mb-2">Sistema Educacional</h1>
            <div class="w-12 h-px bg-gray-300 mx-auto mb-8"></div>

            <p class="text-gray-600 font-light mb-12">Bem-vindo ao sistema.<br>Selecione abaixo a área que deseja
                acessar.</p>

            <div class="flex flex-col sm:flex-row gap-4 justify-center">
                <router-link to="/professores"
                    class="px-6 py-3 border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                    Professores
                </router-link>

                <router-link to="/voluntarios"
                    class="px-6 py-3 border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                    Voluntários
                </router-link>
            </div>
        </div>
    </div>
</template>